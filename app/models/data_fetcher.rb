class DataFetcher
  attr_reader :ticker, :query_hash

  def initialize(ticker:, query_hash:)
    @ticker = ticker
    @query_hash = query_hash
  end

  def get_company_data
    data_responses = {}
    query_hash.each do |metric, quandl_query|
      data_responses[metric] = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_#{quandl_query}.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    end
    data_responses
  end
end
