class DataWorker
  attr_reader :ticker, :type

  def initialize(ticker:, type:)
    @ticker = ticker
    @type = type
  end

  def get_ey_and_roc
    if DataValidator.new(ticker: ticker).data_present?
      if type == :ey
        query_hash = {:ebit => "EBIT_MRQ", :market_cap => "MARKETCAP", :cash_and_equivalents => "CASHNEQ_MRQ", :total_debt => "DEBT_MRQ"}
      elsif type == :roc
        query_hash = {:ebit => "EBIT_MRQ", :total_assets => "ASSETS_MRQ", :current_assets => "ASSETSC_MRQ", :working_capital => "WORKINGCAPITAL_MRQ"}
      end
      data = DataFetcher.new(ticker: ticker, query_hash: query_hash).get_company_data
    end
    if data && DataValidator.new(responses: data.map { |k,v| v }).data_received?
      HashBuilder.new(ticker: ticker, data: data).build_hash
    end
  end
end
