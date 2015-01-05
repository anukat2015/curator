require 'rails_helper'

RSpec.describe DataValidator, :type => :model do
  describe '#data_present?' do
    it 'returns true if data is present' do
      actual = DataValidator.new(ticker: 'AAPL').data_present?
      expect(actual).to be(true)
    end

    it 'returns false if data is not present' do
      actual = DataValidator.new(ticker: 'NOTAREALTICKER').data_present?
      expect(actual).to be(false)
    end
  end

  describe '#data_received?' do
    it 'returns true if data is received' do
      ticker = 'AAPL'
      ebit_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      market_cap_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_MARKETCAP.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      cash_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_CASHNEQ_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      debt_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_DEBT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      actual = DataValidator.new(responses: [ebit_response, market_cap_response, cash_response, debt_response]).data_received?
      expect(actual).to be(true)
    end

    it 'returns false if data is not received' do
      ticker = 'NOTAREALTICKER'
      ebit_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      market_cap_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_MARKETCAP.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      cash_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_CASHNEQ_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      debt_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_DEBT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      actual = DataValidator.new(responses: [ebit_response, market_cap_response, cash_response, debt_response]).data_received?
      expect(actual).to be(false)
    end
  end
end
