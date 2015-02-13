require 'rails_helper'
require 'sample_data'

RSpec.describe DataFactory do
  describe '#make_company_hashes' do
    it 'returns an array of combined hashes' do
      ticker_array = ['AAPL']
      actual = DataFactory.new(ticker_array: ticker_array).make_company_hashes
      expected = [sample_company_data_1]
      expect(actual).to eq(expected)
    end
  end
end
