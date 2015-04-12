class Overseer
  def retrieve_and_persist_data
    get_company_data
    persist_company_data
    add_company_names
  end

  private

  def initialize(ticker_file:)
    @ticker_file = ticker_file
  end

  attr_reader :ticker_file, :company_data

  def get_company_data
    @company_data = DataGatherer.new(ticker_file: ticker_file).gather_data
  end

  def persist_company_data
    ReportCreator.new(data: company_data).create_company_reports
  end

  def add_company_names
    NameFinder.new(file: ticker_file)
  end
end
