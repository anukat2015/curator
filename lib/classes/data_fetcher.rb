class DataFetcher
  def get_company_data
    data_responses = {}
    query_hash.each do |metric, quandl_query|
      data_responses[metric] = HTTParty.get(BASE_URL + "#{ticker}_#{quandl_query}.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      ErrorChecker.new(response: data_responses[metric], ticker: ticker, timeout: 600).check_for_errors
    end
    data_responses
  end

  private

  def initialize(ticker:, query_hash:)
    @ticker = ticker
    @query_hash = query_hash
  end

  attr_reader :ticker, :query_hash

  BASE_URL = "https://www.quandl.com/api/v1/datasets/SF1/"
end
