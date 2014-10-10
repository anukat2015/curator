module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_yahoo_finance_data(ticker_array)
    params = [:name, :symbol, :market_capitalization, :ebitda, :earnings_per_share, :book_value]
    data = YahooFinance.quotes(ticker_array, params)
    data.map { |struct| struct.to_h }
  end
end
