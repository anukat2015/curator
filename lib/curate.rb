require_relative 'stock_reader'

def curate
  ticker_file  = File.open("russell3000.txt", "r")
  ticker_array = StockReader.extract_tickers(ticker_file)
  data         = StockReader.get_earnings_yield(ticker_array)
  num_to_keep  = 50
  company_data_by_ey = StockReader.sort_by_earnings_yield(data, num_to_keep)
  company_data_by_roc = StockReader.sort_by_return_on_capital(data, num_to_keep)
end








StockReader.create_company_reports(curated_data)

StockReader.create_csv(curated_data)

