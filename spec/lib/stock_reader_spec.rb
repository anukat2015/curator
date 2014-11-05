require 'spec_helper'
require 'stock_reader'

RSpec.describe StockReader do

  def earnings_yield_data_1
    {
                       :symbol => "AAPL",
                   :total_debt => 31040000000.0,
              :total_debt_date => "2014-06-28",
                   :market_cap => 581960793730.0,
              :market_cap_date => "2014-07-23",
         :cash_and_equivalents => 12977000000.0,
    :cash_and_equivalents_date => "2014-06-28",
                         :ebit => 10484000000.0,
                    :ebit_date => "2014-06-28",
             :enterprise_value => 600023793730.0,
               :earnings_yield => 0.017472640434518523
    }
  end

  def earnings_yield_data_2
    {
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
               :earnings_yield => 0.023175393420987584
    }
  end

  def return_on_capital_data_1
    {
                  :symbol => "AAPL",
            :total_assets => 222520000000.0,
       :total_assets_date => "2014-06-28",
          :current_assets => 67949000000.0,
     :current_assets_date => "2014-06-28",
         :working_capital => 21744000000.0,
    :working_capital_date => "2014-06-28",
       :return_on_capital => 0.05946175878399455
    }
  end

  def return_on_capital_data_2
    {
                  :symbol => "AIR",
            :total_assets => 2199500000.0,
       :total_assets_date => "2014-05-31",
          :current_assets => 1116900000.0,
     :current_assets_date => "2014-05-31",
         :working_capital => 714800000.0,
    :working_capital_date => "2014-05-31",
       :return_on_capital => 0.01874930455101814
    }
  end

  describe '.extract_tickers' do
    it 'returns a correct array of ticker symbols' do
      test_file = File.open("test_file.txt", "w")
      File.readlines("russell3000.txt").take(4).each { |line| test_file.write(line) }
      test_file.rewind
      expected = ['FLWS', 'SRCE', 'FUBC', 'FOXA']
      expect(StockReader.extract_tickers(test_file)).to eq(expected)
      File.delete("test_file.txt")
    end
  end

  describe '.get_earnings_yield' do
    it 'returns accurate data' do
      test_ticker = 'AAPL'
      actual = StockReader.get_earnings_yield(test_ticker)
      expect(actual).to eq(earnings_yield_data_1)
    end
  end

  describe '.get_return_on_capital' do
    it 'returns accurate data' do
      test_ticker = 'AAPL'
      actual = StockReader.get_return_on_capital(test_ticker)
      expect(actual).to eq(return_on_capital_data_1)
    end
  end

  describe '.retrieve_data' do
    it 'returns an array of combined hashes' do
      ticker_array = ['AAPL']
      actual = StockReader.retrieve_data(ticker_array)
      expected = [return_on_capital_data_1.merge(earnings_yield_data_1)]
      expect(actual).to eq(expected)
    end
  end

  describe '.sort_company_data' do
    it 'sorts by the given metric' do
      company_data = [earnings_yield_data_1, earnings_yield_data_2]
      actual = StockReader.sort_company_data(company_data, :earnings_yield, 30)
      expect(actual).to eq(company_data.reverse)
    end
  end

  describe '.create_company_reports' do
    before(:all) do
      CompanyReportByEarningsYield.delete_all
      CompanyReportByReturnOnCapital.delete_all
    end

    it 'creates earnings yield reports' do
      earnings_yield_array = [earnings_yield_data_1, earnings_yield_data_2]
      StockReader.create_company_reports(earnings_yield_array, CompanyReportByEarningsYield)
      expect(CompanyReportByEarningsYield.count).to eq(2)
    end

    it 'creates return on capital reports' do
      return_on_capital_array = [return_on_capital_data_1, return_on_capital_data_2]
      StockReader.create_company_reports(return_on_capital_array, CompanyReportByReturnOnCapital)
      expect(CompanyReportByReturnOnCapital.count).to eq(2)
    end
  end

  describe '.create_csv' do
    it 'creates csv files' do
      return_on_capital_array = [return_on_capital_data_1, return_on_capital_data_2]
      StockReader.create_csv(return_on_capital_array, "company_report")
      expect(File.file?("company_report.csv")).to be(true)
    end
    after(:all) do
      File.delete("company_report.csv")
    end
  end
end
