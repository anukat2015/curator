require 'rails_helper'
require 'sample_data'

RSpec.describe DataGatherer do
  describe '.initialize' do
    it 'accepts a file' do
      expect { DataGatherer.new(ticker_file: "russell3000.txt") }.not_to raise_error
    end
  end

  describe '#gather_data' do
    it 'returns correct filtered data' do
      actual = DataGatherer.new(ticker_file: "spec/russell5.txt").gather_data
      expected = sample_company_data_array[0...-1]
      expect(actual).to eq(expected)
    end
  end
end
