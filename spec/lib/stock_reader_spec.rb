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
      expected = [{symbol: "FLWS",
                   enterprise_value: 462.7165021151086,
                   enterprise_value_date: "2013-06-27",
                   ebit: 21.649862485391672,
                   ebit_date: "2013-06-27",
                   earnings_yield: 0.046788611139712284},
                  {symbol: "SRCE",
                   enterprise_value: 1051.297512924382,
                   enterprise_value_date: "2012-12-31",
                   ebit: -0.2380449344876999,
                   ebit_date: "2012-12-31",
                   earnings_yield: -0.00022642965626878833}]
      expect(actual).to eq(expected)
    end
  end

  describe 'sort_by_earnings_yield' do
    it 'sorts from highest to lowest' do
      test_array = [{symbol: "SRCE",
                     enterprise_value: 1051.297512924382,
                     enterprise_value_date: "2012-12-31",
                     ebit: -0.2380449344876999,
                     ebit_date: "2012-12-31",
                     earnings_yield: -0.00022642965626878833},
                    {symbol: "FLWS",
                     enterprise_value: 462.7165021151086,
                     enterprise_value_date: "2013-06-27",
                     ebit: 21.649862485391672,
                     ebit_date: "2013-06-27",
                     earnings_yield: 0.046788611139712284}]
      actual = StockReader.sort_by_earnings_yield(test_array, 30)
      expected = [{symbol: "FLWS",
                   enterprise_value: 462.7165021151086,
                   enterprise_value_date: "2013-06-27",
                   ebit: 21.649862485391672,
                   ebit_date: "2013-06-27",
                   earnings_yield: 0.046788611139712284},
                  {symbol: "SRCE",
                   enterprise_value: 1051.297512924382,
                   enterprise_value_date: "2012-12-31",
                   ebit: -0.2380449344876999,
                   ebit_date: "2012-12-31",
                   earnings_yield: -0.00022642965626878833}]
      expect(actual).to eq(expected)
    end
  end

  describe 'create_company_reports' do
    before(:each) do
      CompanyReport.delete_all
    end
    it 'creates reports' do
      test_company_array = [{symbol: "SRCE",
                              enterprise_value: 1051.297512924382,
                              enterprise_value_date: "2012-12-31",
                              ebit: -0.2380449344876999,
                              ebit_date: "2012-12-31",
                              earnings_yield: -0.00022642965626878833},
                             {symbol: "FLWS",
                              enterprise_value: 462.7165021151086,
                              enterprise_value_date: "2013-06-27",
                              ebit: 21.649862485391672,
                              ebit_date: "2013-06-27",
                              earnings_yield: 0.046788611139712284}]
      StockReader.create_company_reports(test_company_array)
      expect(CompanyReport.count).to eq(2)
    end
  end

end
