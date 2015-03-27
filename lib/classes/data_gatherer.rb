class DataGatherer
  def gather_data
    filter_data
  end

  private

  def initialize(ticker_file:)
    @ticker_file = ticker_file
  end

  attr_reader :ticker_file

  def filter_data
    raw_company_data.keep_if do |obj|
      (obj.is_a? Hash) &&
      (obj[:return_on_capital].is_a? Float) &&
      (obj[:earnings_yield].is_a? Float)
    end
  end

  def raw_company_data
    DataFactory.new(ticker_array: tickers).make_company_hashes
  end

  def tickers
    file = File.open(ticker_file, "r")
    TickerExtractor.new(ticker_file: file).extract_tickers
  end
end
