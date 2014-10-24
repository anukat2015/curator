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
      test_ticker = 'AAPL'
      actual = StockReader.get_earnings_yield(test_ticker)
      $company_data =  {symbol: "AAPL",
                        total_debt: 31040000000.0,
                        total_debt_date: "2014-06-28",
                        market_cap: 581960793730.0,
                        market_cap_date: "2014-07-23",
                        cash_and_equivalents: 12977000000.0,
                        cash_and_equivalents_date: "2014-06-28",
                        ebit: 10484000000.0,
                        ebit_date: "2014-06-28",
                        enterprise_value: 600023793730.0,
                        earnings_yield: 0.017472640434518523}

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

  describe '#create_csv' do
    it 'creates csv files' do
      StockReader.create_csv($company_data)
      expect(File.file?("company_report.csv")).to be(true)
    end
    after(:all) do
      File.delete("company_report.csv")
    end
  end
end
