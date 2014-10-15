require 'spec_helper'
require 'stock_reader'

RSpec.describe StockReader do

  describe '#extract_tickers' do
    it 'returns a correct array of ticker symbols' do
      test_file = File.open("test_file.txt", "w")
      File.readlines("russell3000.txt").take(4).each { |line| test_file.write(line) }
      test_file.rewind
      expected = ['FLWS', 'SRCE', 'FUBC', 'FOXA']
      expect(StockReader.extract_tickers(test_file)).to eq(expected)
      File.delete("test_file.txt")
    end
  end

  describe '#get_earnings_yield' do
    it 'returns accurate data' do
      test_tickers = ['FLWS', 'SRCE', 'FOXA']
      actual = StockReader.get_earnings_yield(test_tickers)
      $company_data = [{symbol: "FLWS",
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
      expect(actual).to eq($company_data)
    end
  end

  describe '#sort_by_earnings_yield' do
    it 'sorts from highest to lowest' do
      actual = StockReader.sort_by_earnings_yield($company_data.reverse, 30)
      expect(actual).to eq($company_data)
    end
  end

  describe '#create_company_reports' do
    before(:each) do
      CompanyReport.delete_all
    end
    it 'creates reports' do
      StockReader.create_company_reports($company_data)
      expect(CompanyReport.count).to eq(2)
    end
  end

  describe '#create_xls_file' do
    it 'creates xls files' do
      expect(StockReader.create_xls_file($company_data).class.to_s).to eq('Axlsx::Workbook')
    end
  end

end
