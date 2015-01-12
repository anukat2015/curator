class DataFetcher
  include ErrorChecker

  attr_reader :ticker, :query_hash

  BASE_URL = "https://www.quandl.com/api/v1/datasets/SF1/"

  def initialize(ticker:, query_hash:)
    @ticker = ticker
    @query_hash = query_hash
  end

  def get_company_data
    data_responses = {}
    query_hash.each do |metric, quandl_query|
      data_responses[metric] = HTTParty.get(BASE_URL + "#{ticker}_#{quandl_query}.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      ErrorChecker.check_for_errors(data_responses[metric], ticker)

      sleep 2.5 # Slow down request rate to avoid speed throttling by Quandl

    end
    data_responses
  end
end
