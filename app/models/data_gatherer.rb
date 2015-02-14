class DataGatherer
  def gather_data
  end

  private

  def initialize(ticker_file:)
    @ticker_file = ticker_file
  end

  attr_reader :ticker_file

  def company_data
    @company_data ||= DataFactory.new(
      ticker_array: ticker_array
    ).make_company_hashes
  end

  def ticker_array
    file = File.open(ticker_file, "r")
    TickerExtractor.new(ticker_file: file).extract_tickers
  end
end
