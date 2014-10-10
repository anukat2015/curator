module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_quandl_finance_data(ticker_array)

  end

  def self.calculate_greenblatt_score(hash_array)
  end
end
