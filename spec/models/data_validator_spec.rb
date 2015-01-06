require 'rails_helper'
require 'sample_data'

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
      handles_earnings_yield = DataValidator.new(responses: [earnings_yield_data_1, earnings_yield_data_2]).data_received?
      expect(handles_earnings_yield).to be(true)

      handles_return_on_capital = DataValidator.new(responses: [return_on_capital_data_1, return_on_capital_data_2]).data_received?
      expect(handles_return_on_capital).to be(true)
    end

    it 'returns false if data is not received' do
      actual = DataValidator.new(responses: [error_response]).data_received?
      expect(actual).to be(false)
    end
  end
end
