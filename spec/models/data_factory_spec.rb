require 'rails_helper'
require 'sample_data'

RSpec.describe DataFactory do
  describe '#make_company_hashes' do
    it 'returns an array of combined hashes' do
      ticker_array = TickerExtractor.new(ticker_file: "spec/russell5.txt").extract_tickers
      actual = DataFactory.new(ticker_array: ticker_array).make_company_hashes
      expect(actual).to eq(sample_company_data_array)
    end
  end
end
