class TickerExtractor
  attr_reader :ticker_file

  def initialize(ticker_file:)
    @ticker_file = ticker_file
  end

  def extract_tickers
    File.readlines(ticker_file).map { |line| line.match(/\b(\S+)$/).to_s }
  end
end
