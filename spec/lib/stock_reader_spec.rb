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

  describe 'get_earnings_yield' do
    it 'returns accurate data' do
      test_tickers = ['FLWS', 'SRCE', 'FOXA']
      actual = StockReader.get_earnings_yield(test_tickers)
      expected = [{company: "FLWS",
                   enterprise_value: {"FLWS_EV" => ["2013-06-27", 462.7165021151086]},
                   ebit: {"FLWS_EBIT_1T" => ["2013-06-27", 21.649862485391672]},
                   earnings_yield: 0.046788611139712284
                   },
                   {company: "SRCE",
                    enterprise_value: {"SRCE_EV" => ["2012-12-31", 1051.297512924382]},
                    ebit: {"SRCE_EBIT_1T" => ["2012-12-31", -0.2380449344876999]},
                    earnings_yield: -0.00022642965626878833
                   }]
      expect(actual).to eq(expected)
    end
  end

end
