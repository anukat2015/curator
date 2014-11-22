require 'date'
require_relative 'stock_reader'

def curate(num_to_keep)
  ticker_file   = File.open("russell20.txt", "r")
  ticker_array  = StockReader.extract_tickers(ticker_file)
  processed_data = StockReader.combine_data(ticker_array)
  ey_data = StockReader.sort_company_data(processed_data, :earnings_yield, num_to_keep)
  roc_data = StockReader.sort_company_data(processed_data, :return_on_capital, num_to_keep)
  StockReader.create_company_reports(ey_data, CompanyReportByEarningsYield)
  StockReader.create_company_reports(roc_data, CompanyReportByReturnOnCapital)
  StockReader.create_csv(ey_data, "Earnings Yield #{Date.today}")
  StockReader.create_csv(roc_data, "Return on Capital #{Date.today}")
end

def curate_new(num_to_keep)
  ticker_file = File.open("russell20.txt", "r")
  ticker_array = TickerExtractor.new(ticker_file: ticker_file).extract_tickers
  company_data = DataFactory.new(ticker_array: ticker_array).make_company_hashes
  ey_data = Sorter.new(data: company_data, metric: :earnings_yield, num_to_keep: num_to_keep).sort_company_data
  roc_data = Sorter.new(data: company_data, metric: :return_on_capital, num_to_keep: num_to_keep).sort_company_data
  ReportCreator.new(data: ey_data, type: CompanyReportByEarningsYield).create_company_reports
  ReportCreator.new(data: roc_data, type: CompanyReportByReturnOnCapital).create_company_reports
  Clerk.new(data: ey_data, file_name: "Earnings Yield #{Date.today}").create_csv
  Clerk.new(data: roc_data, file_name: "Return on Capital #{Date.today}").create_csv
end

#curate(20)
curate_new(20)



