class Custodian
  def curate
    persist_reports
  end

  private

  attr_reader :file, :num_to_keep

  def initialize(file:, num_to_keep:)
    @file = file
    @num_to_keep = num_to_keep
  end

  def persist_reports
    ReportCreator.new(data: ey_data).create_company_reports
  end

  def ey_data
    @ey_data ||= Sorter.new(
      data: company_data,
      metric: :earnings_yield,
      num_to_keep: num_to_keep
    ).sort_company_data
  end

  def roc_data
    @roc_data ||= Sorter.new(
      data: company_data,
      metric: :return_on_capital,
      num_to_keep: num_to_keep
    ).sort_company_data
  end

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
