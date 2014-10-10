module StockReader
  def self.extract_tickers(ticker_file)
    ticker_array = []
    File.readlines(ticker_file).each do |line|
      ticker_array << line.match(/\s(\w+)$/).to_s.strip
    end
    ticker_array
  end
end
