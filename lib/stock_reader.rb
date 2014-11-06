require 'csv'
require 'httparty'

module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.data_exists?(response_array)
    response_array.map { |res| res["data"] }.none? { |data| data.to_a.empty? }
  end

  def self.get_company_data(ticker, query_hash)
    data_responses = {}
    query_hash.each do |metric, quandl_query|
      data_responses[metric] = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_#{quandl_query}.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    end
    data_responses
  end

  def self.process_data_hash(symbol, data_hash)

  end

  def self.get_earnings_yield(ticker)
    ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    if ebit_response.size > 1
      ey_query_hash = {:market_cap => "MARKETCAP", :cash => "CASHNEQ_MRQ", :debt => "DEBT_MRQ"}
      ey_data = get_company_data(ticker, ey_query_hash)
      if data_exists?([ebit_response, ey_data[:market_cap], ey_data[:cash], ey_data[:debt]])
        ebit       = ebit_response["data"].flatten[1]
        market_cap = ey_data[:market_cap]["data"].flatten[1]
        debt       = ey_data[:debt]["data"].flatten[1]
        cash       = ey_data[:cash]["data"].flatten[1]
        ev         = (market_cap + debt) - cash
        ey         = ebit / ev
        {
                           symbol: ticker,
                       total_debt: debt,
                  total_debt_date: ey_data[:debt]["data"].flatten[0],
                       market_cap: market_cap,
                  market_cap_date: ey_data[:market_cap]["data"].flatten[0],
             cash_and_equivalents: cash,
        cash_and_equivalents_date: ey_data[:cash]["data"].flatten[0],
                             ebit: ebit,
                        ebit_date: ebit_response["data"].flatten[0],
                 enterprise_value: ev,
                   earnings_yield: ey
        }
      end
    end
  end

  def self.get_return_on_capital(ticker)
    ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    if ebit_response.size > 1
      roc_query_hash = {:total_assets => "ASSETS_MRQ", :current_assets => "ASSETSC_MRQ", :working_capital => "WORKINGCAPITAL_MRQ"}
      roc_data = get_company_data(ticker, roc_query_hash)
      if data_exists?([ebit_response, roc_data[:total_assets], roc_data[:current_assets], roc_data[:working_capital]])
        ebit              = ebit_response["data"].flatten[1]
        total_assets      = roc_data[:total_assets]["data"].flatten[1]
        current_assets    = roc_data[:current_assets]["data"].flatten[1]
        working_capital   = roc_data[:working_capital]["data"].flatten[1]
        net_fixed_assets  = total_assets - current_assets
        return_on_capital = ebit / (net_fixed_assets + working_capital)
        {
                      symbol: ticker,
                total_assets: total_assets,
           total_assets_date: roc_data[:total_assets]["data"].flatten[0],
              current_assets: current_assets,
         current_assets_date: roc_data[:current_assets]["data"].flatten[0],
             working_capital: working_capital,
        working_capital_date: roc_data[:working_capital]["data"].flatten[0],
           return_on_capital: return_on_capital
        }
      end
    end
  end

  def self.retrieve_data(ticker_array)
    ticker_array.map do |ticker|
      ey = get_earnings_yield(ticker)
      roc = get_return_on_capital(ticker)
      ey.merge(roc) if ey && roc
    end
  end

  def self.sort_company_data(company_data, metric, num_to_keep)
    company_data.reject! { |company| company[metric].nil? || company[metric].nan? }
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
