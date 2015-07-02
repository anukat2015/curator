class TickerExtractor
  def extract_tickers
    File.readlines(ticker_file).map { |line| line.match(/\b(\S+)$/).to_s }
  end

  private

  def initialize(ticker_file:)
    @ticker_file = ticker_file
  end

  attr_reader :ticker_file
end
