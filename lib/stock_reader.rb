require 'csv'
require 'httparty'
require 'pry'

module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.data_exists?(response_array)
    response_array.map { |res| res["data"] }.none? { |data| data.to_a.empty? }
  end

  def self.get_earnings_yield(ticker)
    ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    if ebit_response.size > 1
      market_cap_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_MARKETCAP.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      cash_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_CASHNEQ_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      debt_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_DEBT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      if [ebit_response["data"], market_cap_response["data"], cash_response["data"], debt_response["data"]].none? { |data| data.to_a.empty? }
        ebit       = ebit_response["data"].flatten[1]
        market_cap = market_cap_response["data"].flatten[1]
        debt       = debt_response["data"].flatten[1]
        cash       = cash_response["data"].flatten[1]
        ev         = (market_cap + debt) - cash
        ey         = ebit / ev
                          {symbol: ticker,
                       total_debt: debt,
                  total_debt_date: debt_response["data"].flatten[0],
                       market_cap: market_cap,
                  market_cap_date: market_cap_response["data"].flatten[0],
             cash_and_equivalents: cash,
        cash_and_equivalents_date: cash_response["data"].flatten[0],
                             ebit: ebit,
                        ebit_date: ebit_response["data"].flatten[0],
                 enterprise_value: ev,
                   earnings_yield: ey}
      end
    else
      nil
    end
  end

  def self.get_return_on_capital(ticker)
    ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    if ebit_response.size > 1
      total_assets_response    = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_ASSETS_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      current_assets_response  = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_ASSETSC_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      working_capital_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_WORKINGCAPITAL_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      if [ebit_response["data"], total_assets_response["data"], current_assets_response["data"], working_capital_response["data"]].none? { |data| data.to_a.empty? }
        ebit              = ebit_response["data"].flatten[1]
        total_assets      = total_assets_response["data"].flatten[1]
        current_assets    = current_assets_response["data"].flatten[1]
        working_capital   = working_capital_response["data"].flatten[1]
        net_fixed_assets  = total_assets - current_assets
        return_on_capital = ebit / (net_fixed_assets + working_capital)
                     {symbol: ticker,
                total_assets: total_assets,
           total_assets_date: total_assets_response["data"].flatten[0],
              current_assets: current_assets,
         current_assets_date: current_assets_response["data"].flatten[0],
             working_capital: working_capital,
        working_capital_date: working_capital_response["data"].flatten[0],
           return_on_capital: return_on_capital}
      end
    else
      nil
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
      company_report.create(
                           symbol: company[:symbol],
                             ebit: company[:ebit].to_s,
                        ebit_date: company[:ebit_date],
                       market_cap: company[:market_cap].to_s,
                  market_cap_date: company[:market_cap_date],
                  working_capital: company[:working_capital].to_s,
             working_capital_date: company[:working_capital_date],
                     total_assets: company[:total_assets].to_s,
                total_assets_date: company[:total_assets_date],
                   current_assets: company[:current_assets].to_s,
              current_assets_date: company[:current_assets_date],
                       total_debt: company[:total_debt].to_s,
                  total_debt_date: company[:total_debt_date],
             cash_and_equivalents: company[:cash_and_equivalents].to_s,
        cash_and_equivalents_date: company[:cash_and_equivalents_date],
                     fixed_assets: company[:fixed_assets],
                 enterprise_value: company[:enterprise_value],
                   earnings_yield: company[:earnings_yield],
                return_on_capital: company[:return_on_capital])
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
