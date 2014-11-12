require 'date'
require 'benchmark'
require_relative 'stock_reader'

def curate(num_to_keep)
  ticker_file   = File.open("russell3000.txt", "r")
  ticker_array  = StockReader.extract_tickers(ticker_file)
  processed_data = StockReader.combine_data(ticker_array)
  ey_data = StockReader.sort_company_data(processed_data, :earnings_yield, num_to_keep)
  roc_data = StockReader.sort_company_data(processed_data, :return_on_capital, num_to_keep)
  StockReader.create_company_reports(ey_data, CompanyReportByEarningsYield)
  StockReader.create_company_reports(roc_data, CompanyReportByReturnOnCapital)
  StockReader.create_csv(ey_data, "Earnings Yield #{Date.today}")
  StockReader.create_csv(roc_data, "Return on Capital #{Date.today}")
end

curate(50)




