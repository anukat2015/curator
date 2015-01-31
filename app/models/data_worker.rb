class DataWorker
  def get_ey_and_roc
    if data_exists?
      assign_queries
      retrieve_data
      build_hash if data_retrieved?
    end
  end

  private

  attr_reader :ticker, :type, :query_hash, :data

  def initialize(ticker:, type:)
    @ticker = ticker
    @type = type
  end

  def data_exists?
    DataValidator.new(ticker: ticker).data_present?
  end

  def assign_queries
    if type == :ey
      @query_hash = earnings_yield_query_hash
    elsif type == :roc
      @query_hash = return_on_capital_query_hash
    end
  end

  def earnings_yield_query_hash
    {:ebit => "EBIT_MRQ", :market_cap => "MARKETCAP", :cash_and_equivalents => "CASHNEQ_MRQ", :total_debt => "DEBT_MRQ"}
  end

  def return_on_capital_query_hash
    {:ebit => "EBIT_MRQ", :total_assets => "ASSETS_MRQ", :current_assets => "ASSETSC_MRQ", :working_capital => "WORKINGCAPITAL_MRQ"}
  end

  def retrieve_data
    @data = fetched_data
  end

  def data_retrieved?
    data && DataValidator.new(responses: data.map { |k,v| v }).data_received?
  end

  def fetched_data
    DataFetcher.new(ticker: ticker, query_hash: query_hash).get_company_data
  end

  def build_hash
    HashBuilder.new(ticker: ticker, data: data).build_hash
  end
end
