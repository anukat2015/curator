require 'date'
require_relative 'stock_reader'

def curate(num_to_keep)
  ticker_file   = File.open("russell20.txt", "r")
  ticker_array  = StockReader.extract_tickers(ticker_file)
  combined_data = StockReader.retrieve_data(ticker_array)
  data_by_ey    = StockReader.sort_by_earnings_yield(combined_data, num_to_keep)
  data_by_roc   = StockReader.sort_by_return_on_capital(combined_data, num_to_keep)
  StockReader.create_company_reports(data_by_ey, CompanyReportByEarningsYield)
  StockReader.create_company_reports(data_by_roc, CompanyReportByReturnOnCapital)
  StockReader.create_csv(data_by_ey, "Earnings Yield #{Date.today}")
  StockReader.create_csv(data_by_roc, "Return on Capital #{Date.today}")
end

curate(10)




