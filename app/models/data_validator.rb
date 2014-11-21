class DataValidator
  attr_reader :ticker, :responses

  def initialize(options = {})
    @ticker = options[:ticker]
    @responses = options[:responses]
  end

  def data_present?
    response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    response.size > 1
  end

  def data_received?
    responses.map { |res| res["data"] }.none? { |data| data.to_a.empty? }
  end
end
