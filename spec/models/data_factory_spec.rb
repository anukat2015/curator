require 'rails_helper'
require 'sample_data'

RSpec.describe DataFactory, :type => :model do
  describe '#make_company_hashes' do
    it 'returns an array of combined hashes' do
      ticker_array = ['AAPL']
      actual = DataFactory.new(ticker_array: ticker_array).make_company_hashes
      expected = [return_on_capital_data_1.merge(earnings_yield_data_1)]
      expect(actual).to eq(expected)
    end
  end
end
