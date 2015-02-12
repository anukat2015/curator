class DataGatherer
  def gather_data
  end

  private

  def initialize(file:)
    @file = file
  end

  attr_reader :file

  def company_data
    @company_data ||= DataFactory.new(
      ticker_array: ticker_array
    ).make_company_hashes
  end

  def ticker_array
    ticker_file = File.open(file, "r")
    TickerExtractor.new(ticker_file: ticker_file).extract_tickers
  end
end
