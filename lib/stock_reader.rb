module StockReader
  def self.extract_tickers(ticker_file)
    File.readlines(ticker_file).map { |line| line.match(/\s(\w+)$/).to_s.strip }
  end

  def self.get_earnings_yield(ticker_array)
    company_data = []
    ticker_array.each do |ticker|
      ev_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/DMDRN/#{ticker}_EV.json?rows=1&auth_token=#{ENV['QUANDL_TOKEN']}")
      ebit_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/DMDRN/#{ticker}_EBIT_1T.json?rows=1&auth_token=#{ENV['QUANDL_TOKEN']}")
      if ev_response["code"] && ebit_response["code"]
        company_data << { company: ticker,
                          enterprise_value: ev_response["data"].flatten[1],
                          enterprise_value_date: ev_response["data"].flatten[0],
                          ebit: ebit_response["data"].flatten[1],
                          ebit_date: ebit_response["data"].flatten[0],
                          earnings_yield: ebit_response["data"].flatten[1] / ev_response["data"].flatten[1] }
      end
    end
    company_data
  end

  def self.calculate_greenblatt_score(hash_array)
  end
end
