module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_earnings_yield(ticker_array)
    company_data = []
    ticker_array.each do |ticker|
      ev_response = HTTParty.get('https://www.quandl.com/api/v1/datasets/DMDRN/'+ticker+'_EV.json?rows=1&auth_token='+ENV['QUANDL_TOKEN'])
      ebit_response = HTTParty.get('https://www.quandl.com/api/v1/datasets/DMDRN/'+ticker+'_EBIT_1T.json?rows=1&auth_token='+ENV['QUANDL_TOKEN'])
      if ev_response["code"] && ebit_response["code"]
        company_data << { ev_response["code"] => ev_response["data"].flatten }
      end
    end
    company_data
  end

  def self.calculate_greenblatt_score(hash_array)
  end
end
