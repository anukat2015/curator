require 'date'

def curate(num_to_keep)
  ticker_file = File.open("russell3000.txt", "r")
  ticker_array = TickerExtractor.new(ticker_file: ticker_file).extract_tickers
  company_data = DataFactory.new(ticker_array: ticker_array).make_company_hashes
  ey_data = Sorter.new(data: company_data, metric: :earnings_yield, num_to_keep: num_to_keep).sort_company_data
  roc_data = Sorter.new(data: company_data, metric: :return_on_capital, num_to_keep: num_to_keep).sort_company_data
  ReportCreator.new(data: ey_data, type: CompanyReportByEarningsYield).create_company_reports
  ReportCreator.new(data: roc_data, type: CompanyReportByReturnOnCapital).create_company_reports
  Clerk.new(data: ey_data, file_name: "Earnings Yield #{Date.today}").create_csv
  Clerk.new(data: roc_data, file_name: "Return on Capital #{Date.today}").create_csv
end

curate(50)



