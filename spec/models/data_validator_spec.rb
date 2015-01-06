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
      actual = DataValidator.new(responses: sample_response_array).data_received?
      expect(actual).to be(true)
    end

    it 'returns false if data is not received' do
      actual = DataValidator.new(responses: [error_response]).data_received?
      expect(actual).to be(false)
    end
  end
end
