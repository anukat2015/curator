require 'rails_helper'
require 'sample_data'

RSpec.describe DataGatherer do

  describe '.initialize' do
    it 'accepts a file' do
      expect { DataGatherer.new(ticker_file: "russell3000.txt") }.not_to raise_error
    end
  end

  describe '#gather_data' do
    it 'gathers data correctly' do
      actual = DataGatherer.new(ticker_file: "spec/russell5.txt").gather_data
      expect(actual).to eq(sample_company_data_array)
    end
  end
end
