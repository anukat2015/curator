require 'csv'
require 'httparty'

module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_earnings_yield(ticker)
    # company_data.reject { |company| company[:earnings_yield].nan? }
  end

  def self.get_return_on_capital(ticker)
  end

  def self.combine_data(ticker_array)
  end

  def self.sort_by_earnings_yield(company_data, num_to_keep)
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
