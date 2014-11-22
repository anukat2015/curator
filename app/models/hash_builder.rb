class HashBuilder
  attr_reader :ticker, :data

  def initialize(ticker:, data:)
    @ticker = ticker
    @data = data
  end

  def build_hash
    h = {:symbol => ticker}
    data.each do |key, data_obj|
      h[key] = data_obj["data"].flatten[1]
      data_key = (key.to_s << "_date").to_sym
      h[data_key] = data_obj["data"].flatten[0]
    end
    Accountant.new(data: h).calculate_ey_and_roc
  end
end
