module StockReader
  def self.extract_tickers(ticker_file)
    ticker_array = []
    File.readlines(ticker_file).each do |line|
      ticker_array << line.match(/\s(\w+)$/).to_s.strip
    end
    ticker_array
  end

  def self.get_yahoo_finance_data(ticker_array)
    params = [:name, :symbol, :market_capitalization, :ebitda, :earnings_per_share, :book_value]
    data = YahooFinance.quotes(ticker_array, params)
  end
end
