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

  describe 'get_yahoo_finance_data' do
    it 'returns YahooFinance data' do
      test_tickers = ['FLWS', 'SRCE', 'FUBC', 'FOXA']
      actual = StockReader.get_yahoo_finance_data(test_tickers)[0].keys
      expected = [:symbol, :name, :market_capitalization, :ebitda, :earnings_per_share, :book_value]
      expect(actual).to eq(expected)
    end
  end

end
