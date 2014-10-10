require 'spec_helper'
require 'stock_reader'

RSpec.describe StockReader do
  describe 'adder' do
    it 'returns the sum of its arguments' do
      expect(StockReader.adder(1,2)).to eq(3)
    end
  end

  describe 'extract_tickers' do
    it 'returns an array of ticker symbols' do
      test_file = File.open("test_file.txt", "w")
      File.readlines("russell3000.txt").take(4).each { |line| test_file.write(line) }
      test_file.rewind
      expected = ['FLWS', 'SRCE', 'FUBC', 'FOXA']
      expect(StockReader.extract_tickers(test_file)).to eq(expected)
    end
  end

end
