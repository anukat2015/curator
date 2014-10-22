require 'csv'
require 'httparty'

module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_earnings_yield(ticker_array)
    company_data = []
    ticker_array.each do |ticker|
      ev_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/DMDRN/#{ticker}_EV.json?rows=1&auth_token=#{ENV['QUANDL_TOKEN']}")
      ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/DMDRN/#{ticker}_EBIT_1T.json?rows=1&auth_token=#{ENV['QUANDL_TOKEN']}")
      if ev_response["code"] && ebit_response["code"]
        company_data << { symbol: ticker,
                          enterprise_value: ev_response["data"].flatten[1],
                          enterprise_value_date: ev_response["data"].flatten[0],
                          ebit: ebit_response["data"].flatten[1],
                          ebit_date: ebit_response["data"].flatten[0],
                          earnings_yield: ebit_response["data"].flatten[1] / ev_response["data"].flatten[1] }
      end
    end
    company_data
  end

  def self.sort_by_earnings_yield(company_data, num_to_keep)
    company_data.sort_by { |company| company[:earnings_yield] }.reverse.take(num_to_keep)
  end

  def self.create_company_reports(company_data_array)
    company_data_array.each do |company|
      CompanyReport.create(symbol: company[:company], enterprise_value: company[:enterprise_value], enterprise_value_date: company[:enterprise_value_date], ebit: company[:ebit], ebit_date: company[:ebit_date], earnings_yield: company[:earnings_yield])
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
