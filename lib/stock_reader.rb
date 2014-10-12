module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_quandl_finance_data(ticker_array)
    r = HTTParty.get('https://www.quandl.com/api/v1/datasets/DMDRN/AAPL_EV.json?.trim_start=2014-1-01')
  end

  def self.calculate_greenblatt_score(hash_array)
  end
end
