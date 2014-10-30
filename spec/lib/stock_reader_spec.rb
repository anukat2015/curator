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
      $earnings_yield_data = {symbol: "AAPL",
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
      expect(actual).to eq($earnings_yield_data)
    end
  end

  describe '#get_return_on_capital' do
    it 'returns accurate data' do
      test_ticker = 'AAPL'
      actual = StockReader.get_return_on_capital(test_ticker)
      $return_on_capital_data = {symbol: "AAPL",
                                 total_assets: 222520000000.0,
                                 total_assets_date: "2014-06-28",
                                 current_assets: 67949000000.0,
                                 current_assets_date: "2014-06-28",
                                 working_capital: 21744000000.0,
                                 working_capital_date: "2014-06-28",
                                 return_on_capital: 0.05946175878399455}
      expect(actual).to eq($return_on_capital_data)
    end
  end

  describe '#combine_data' do
    it 'returns an array of combined hashes' do
      ticker_array = ['AAPL']
      actual = StockReader.combine_data(ticker_array)
      expected = [$return_on_capital_data.merge($earnings_yield_data)]
      expect(actual).to eq(expected)
    end
  end

  describe '#sort_by_earnings_yield' do
    it 'sorts from highest to lowest' do
      test_earnings_data = {
                       :symbol => "SRCE",
                   :total_debt => 468492000.0,
              :total_debt_date => "2014-06-30",
                   :market_cap => 689213538.87,
              :market_cap_date => "2014-07-24",
         :cash_and_equivalents => 117378000.0,
    :cash_and_equivalents_date => "2014-06-30",
                         :ebit => 24110000.0,
                    :ebit_date => "2014-06-30",
             :enterprise_value => 1040327538.8699999,
               :earnings_yield => 0.023175393420987584}

      $earnings_yield_array = [$earnings_yield_data, test_earnings_data]
      actual = StockReader.sort_by_earnings_yield($earnings_yield_array, 30)
      expect(actual).to eq($earnings_yield_array.reverse)
    end
  end

  describe '#sort_by_return_on_capital' do
    it 'sorts from highest to lowest' do
      test_roc_data = {
                  :symbol => "AIR",
            :total_assets => 2199500000.0,
       :total_assets_date => "2014-05-31",
          :current_assets => 1116900000.0,
     :current_assets_date => "2014-05-31",
         :working_capital => 714800000.0,
    :working_capital_date => "2014-05-31",
       :return_on_capital => 0.01874930455101814}

       $return_on_capital_array = [test_roc_data, $return_on_capital_data]
      actual = StockReader.sort_by_return_on_capital($return_on_capital_array, 30)
      expect(actual).to eq($return_on_capital_array.reverse)
    end
  end

  describe '#create_company_reports_by_roc' do
    before(:each) do
      CompanyReportByReturnOnCapital.delete_all
    end
    it 'creates reports' do
      StockReader.create_company_reports_by_roc($return_on_capital_array)
      expect(CompanyReportByReturnOnCapital.count).to eq(2)
    end
  end

  describe '#create_csv' do
    it 'creates csv files' do
      StockReader.create_csv($return_on_capital_array)
      expect(File.file?("company_report.csv")).to be(true)
    end
    after(:all) do
      File.delete("company_report.csv")
    end
  end
end
