require_relative 'stock_reader'

ticker_file = File.open("russell3000.txt", "r")

ticker_array = StockReader.extract_tickers(ticker_file)

data = StockReader.get_earnings_yield(ticker_array)

num_to_keep = 50
curated_data = StockReader.sort_by_earnings_yield(data, num_to_keep)

#StockReader.create_company_reports(curated_data)

StockReader.create_csv(curated_data)

