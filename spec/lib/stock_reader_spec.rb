require 'spec_helper'
require 'stock_reader'

RSpec.describe StockReader do

  describe 'extract_tickers' do
    it 'returns a correct array of ticker symbols' do
      test_file = File.open("test_file.txt", "w")
      File.readlines("russell3000.txt").take(4).each { |line| test_file.write(line) }
      test_file.rewind
      expected = ['FLWS', 'SRCE', 'FUBC', 'FOXA']
      expect(StockReader.extract_tickers(test_file)).to eq(expected)
      File.delete("test_file.txt")
    end
  end

  describe 'get_quandl_finance_data' do
    it 'returns Quandl data' do
      test_tickers = ['FLWS', 'SRCE', 'FUBC', 'FOXA']
    end
  end

end
