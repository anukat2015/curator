require 'csv'
require 'httparty'

module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.data_present?(ticker)
    response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    response.size > 1
  end

  def self.data_received?(response_array)
    response_array.map { |res| res["data"] }.none? { |data| data.to_a.empty? }
  end

  def self.get_company_data(ticker, query_hash)
    data_responses = {}
    query_hash.each do |metric, quandl_query|
      data_responses[metric] = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_#{quandl_query}.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    end
    data_responses
  end

  def self.calculate_ey_and_roc(data)
    if data[:market_cap]
      data[:enterprise_value] = (data[:market_cap] + data[:total_debt]) - data[:cash_and_equivalents]
      data[:earnings_yield] = data[:ebit] / data[:enterprise_value]
    elsif data[:total_assets] && data[:current_assets]
      net_fixed_assets = data[:total_assets] - data[:current_assets]
      data[:return_on_capital] = data[:ebit] / (net_fixed_assets + data[:working_capital])
    end
    data
  end

  def self.process_data_hash(symbol, data_hash)
    h = {:symbol => symbol}
    data_hash.each do |key, data_obj|
      h[key] = data_obj["data"].flatten[1]
      data_key = (key.to_s << "_date").to_sym
      h[data_key] = data_obj["data"].flatten[0]
    end
    calculate_ey_and_roc(h)
    h
  end

  def self.get_ey_and_roc(ticker, type)
    if data_present?(ticker)
      if type == :ey
        query_hash = {:ebit => "EBIT_MRQ", :market_cap => "MARKETCAP", :cash_and_equivalents => "CASHNEQ_MRQ", :total_debt => "DEBT_MRQ"}
      elsif type == :roc
        query_hash = {:ebit => "EBIT_MRQ", :total_assets => "ASSETS_MRQ", :current_assets => "ASSETSC_MRQ", :working_capital => "WORKINGCAPITAL_MRQ"}
      end
      data = get_company_data(ticker, query_hash)
    end
    if data && data_received?(data.map { |k,v| v })
      process_data_hash(ticker, data)
    end
  end

  def self.combine_data(ticker_array)
    ticker_array.map do |ticker|
      ey = get_ey_and_roc(ticker, :ey)
      roc = get_ey_and_roc(ticker, :roc)
      puts "Done with #{ticker} No. #{ticker_array.index(ticker)}"
      ey.merge(roc) if ey && roc
    end
  end

  def self.sort_company_data(company_data, metric, num_to_keep)
    company_data.reject! { |company| company.nil? || company[metric].nil? || company[metric].nan? }
    company_data.sort_by { |company| company[metric].to_f }.reverse.take(num_to_keep)
  end

  def self.create_company_reports(company_data_array, company_report)
    company_data_array.each do |company|
      company_report.create(company.each { |k,v| company[k] = v.to_s })
    end
  end

  def self.create_csv(company_data_array, file_name)
    CSV.open("#{file_name}.csv", "wb") do |csv|
      csv << company_data_array.first.map { |k, v| k.to_s.capitalize.gsub("_", " ") }
      company_data_array.each do |data|
        csv << data.each_value.map { |val| val.to_s }
      end
    end
  end
end
