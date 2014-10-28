require 'csv'
require 'httparty'

module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_earnings_yield(ticker)
    ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    market_cap_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_MARKETCAP.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    cash_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_CASHNEQ_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    debt_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_DEBT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    if ebit_response["data"] && market_cap_response["data"] && cash_response["data"] && debt_response["data"]
      ebit = ebit_response["data"].flatten[1]
      market_cap = market_cap_response["data"].flatten[1]
      debt = debt_response["data"].flatten[1]
      cash = cash_response["data"].flatten[1]
      ev = (market_cap + debt) - cash
      ey = ebit / ev
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
    else
      p "#{ticker} earnings yield retrieval failed."
    end
  end

  def self.get_return_on_capital(ticker)
    ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    total_assets_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_ASSETS_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    current_assets_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_ASSETSC_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    working_capital_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_WORKINGCAPITAL_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    if ebit_response["data"] && total_assets_response["data"] && current_assets_response["data"] && working_capital_response["data"]
      ebit = ebit_response["data"].flatten[1]
      total_assets = total_assets_response["data"].flatten[1]
      current_assets = current_assets_response["data"].flatten[1]
      working_capital = working_capital_response["data"].flatten[1]
      net_fixed_assets = total_assets - current_assets
      return_on_capital = ebit / (net_fixed_assets + working_capital)
      {symbol: ticker,
       total_assets: total_assets,
       total_assets_date: total_assets_response["data"].flatten[0],
       current_assets: current_assets,
       current_assets_date: current_assets_response["data"].flatten[0],
       working_capital: working_capital,
       working_capital_date: working_capital_response["data"].flatten[0],
       return_on_capital: return_on_capital}
     else
      p "#{ticker} return on capital retrieval failed."
    end
  end

  def self.combine_data(ticker_array)
    company_data = []
    ticker_array.each do |ticker|
      company_data << get_earnings_yield(ticker).merge(get_return_on_capital(ticker))
    end
    company_data
  end

  def self.sort_by_earnings_yield(company_data, num_to_keep)
    company_data.reject! { |company| company[:earnings_yield].nan? }
    company_data.sort_by { |company| company[:earnings_yield].to_f }.reverse.take(num_to_keep)
  end

  def self.create_company_reports(company_data_array)
    company_data_array.each do |company|
      CompanyReport.create(symbol: company[:symbol], enterprise_value: company[:enterprise_value].to_s, enterprise_value_date: company[:enterprise_value_date], ebit: company[:ebit].to_s, ebit_date: company[:ebit_date], earnings_yield: company[:earnings_yield].to_s)
    end
  end

  def self.create_csv(company_data_array)
    CSV.open("company_report.csv", "wb") do |csv|
      csv << ["Symbol", "Enterprise Value", "Enterprise Value Date", "EBIT", "EBIT Date", "Earnings Yield"]
      company_data_array.each do |data|
        csv << data.each_value.map { |val| val.to_s }
      end
    end
  end
end
