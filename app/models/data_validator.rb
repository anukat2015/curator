class DataValidator
  attr_reader :ticker

  def initialize(ticker = nil)
    @ticker = ticker
  end

  def data_present?
    response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
    response.size > 1
  end

  def data_received?(response_array)
    response_array.map { |res| res["data"] }.none? { |data| data.to_a.empty? }
  end
end
