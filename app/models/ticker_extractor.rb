class TickerExtractor
  attr_reader :ticker_file

  def initialize(ticker_file:)
    @ticker_file = ticker_file
  end

  def extract_tickers
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end
end
