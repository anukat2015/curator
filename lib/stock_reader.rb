module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_enterprise_value(ticker_array)
    ev_data = []
    ticker_array.each do |ticker|
      response = HTTParty.get('https://www.quandl.com/api/v1/datasets/DMDRN/'+ticker+'_EV.json?rows=1&auth_token='+ENV['QUANDL_TOKEN'])
      ev_data << { response["code"] => response["data"].flatten }
    end
    ev_data
  end

  def self.calculate_greenblatt_score(hash_array)
  end
end
