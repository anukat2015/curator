class HashBuilder
  def build_hash
    h = {:symbol => ticker}
    data.each do |key, response_obj|
      h[key] = get_value(response_obj)
      date_key = (key.to_s << "_date").to_sym
      h[date_key] = get_date(response_obj)
    end
    Accountant.new(data: h).calculate_ey_and_roc
  end

  private

  attr_reader :ticker, :data

  def initialize(ticker:, data:)
    @ticker = ticker
    @data = data
  end

  def get_value(response_object)
    response_object["data"].flatten[1]
  end

  def get_date(response_object)
    response_object["data"].flatten[0]
  end
end
