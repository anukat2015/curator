require 'spec_helper'
require 'stock_reader'
require 'sample_data'

RSpec.describe StockReader do

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

  describe '.data_present?' do
    it 'checks for data' do
      ticker = 'AAPL'
      expect(StockReader.data_present?(ticker)).to be(true)
    end
  end

  describe '.data_received?' do
    it 'checks whether each response is empty' do
      ticker = 'AAPL'
      ebit_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_EBIT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      market_cap_response = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_MARKETCAP.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      cash_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_CASHNEQ_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      debt_response       = HTTParty.get("https://www.quandl.com/api/v1/datasets/SF1/#{ticker}_DEBT_MRQ.json?rows=1&auth_token=#{ENV['QUANDL_AUTH_TOKEN']}")
      actual = StockReader.data_received?([ebit_response, market_cap_response, cash_response, debt_response])
      expect(actual).to be(true)
    end
  end

  describe '.get_company_data' do
    it 'retrieves data for calculating earnings yield' do
      ticker = 'AAPL'
      ey_hash = {:market_cap => "MARKETCAP", :cash => "CASHNEQ_MRQ", :debt => "DEBT_MRQ"}
      ey_data = StockReader.get_company_data(ticker, ey_hash)
      expect(ey_data[:market_cap]["data"].flatten[1]).to be_kind_of(Float)
      expect(ey_data[:cash]["data"].flatten[1]).to be_kind_of(Float)
      expect(ey_data[:debt]["data"].flatten[1]).to be_kind_of(Float)
    end
    it 'retrieves data for calculating return on capital' do
      ticker = 'AAPL'
      roc_hash = {:total_assets => "ASSETS_MRQ", :current_assets => "ASSETSC_MRQ", :working_capital => "WORKINGCAPITAL_MRQ"}
      roc_data = StockReader.get_company_data(ticker, roc_hash)
      expect(roc_data[:total_assets]["data"].flatten[1]).to be_kind_of(Float)
      expect(roc_data[:current_assets]["data"].flatten[1]).to be_kind_of(Float)
      expect(roc_data[:working_capital]["data"].flatten[1]).to be_kind_of(Float)
    end
  end

  describe '.calculate_ey_and_roc' do
    it 'calculates properly' do
      ey_hash =
      {
         :symbol => "AAPL",
         :ebit => 10484000000.0,
         :ebit_date => "2014-06-28",
         :market_cap => 581960793730.0,
         :market_cap_date => "2014-07-23",
         :cash_and_equivalents => 12977000000.0,
         :cash_and_equivalents_date => "2014-06-28",
         :total_debt => 31040000000.0,
         :total_debt_date => "2014-06-28"
      }
      roc_hash =
      {
        :symbol => "AAPL",
         :ebit => 10484000000.0,
         :ebit_date => "2014-06-28",
         :total_assets => 222520000000.0,
         :total_assets_date => "2014-06-28",
         :current_assets => 67949000000.0,
         :current_assets_date => "2014-06-28",
         :working_capital => 21744000000.0,
         :working_capital_date => "2014-06-28"
      }

      completed_ey_hash = StockReader.calculate_ey_and_roc(ey_hash)
      completed_roc_hash = StockReader.calculate_ey_and_roc(roc_hash)
      ev = (ey_hash[:market_cap] + ey_hash[:total_debt]) - ey_hash[:cash_and_equivalents]
      ey = ey_hash[:ebit] / ev
      net_fixed_assets = roc_hash[:total_assets] - roc_hash[:current_assets]
      roc = roc_hash[:ebit] / (net_fixed_assets + roc_hash[:working_capital])

      expect(completed_ey_hash[:enterprise_value]).to eq(ev)
      expect(completed_ey_hash[:earnings_yield]).to eq(ey)
      expect(completed_roc_hash[:return_on_capital]).to eq(roc)
    end
  end

  describe '.process_data_hash' do
    it 'processes the given data' do
      ticker = 'AAPL'
      ey_query_hash = {:ebit => "EBIT_MRQ", :market_cap => "MARKETCAP", :cash_and_equivalents => "CASHNEQ_MRQ", :total_debt => "DEBT_MRQ"}
      ey_data = StockReader.get_company_data(ticker, ey_query_hash)
      actual = StockReader.process_data_hash(ticker, ey_data)
      test_hash = {
                         symbol: ticker,
                     total_debt: ey_data[:total_debt]["data"].flatten[1],
                total_debt_date: ey_data[:total_debt]["data"].flatten[0],
                     market_cap: ey_data[:market_cap]["data"].flatten[1],
                market_cap_date: ey_data[:market_cap]["data"].flatten[0],
           cash_and_equivalents: ey_data[:cash_and_equivalents]["data"].flatten[1],
      cash_and_equivalents_date: ey_data[:cash_and_equivalents]["data"].flatten[0],
                           ebit: ey_data[:ebit]["data"].flatten[1],
                      ebit_date: ey_data[:ebit]["data"].flatten[0],
      }
      test_hash[:enterprise_value] = (test_hash[:market_cap] + test_hash[:total_debt]) - test_hash[:cash_and_equivalents]
      test_hash[:earnings_yield] = test_hash[:ebit] / test_hash[:enterprise_value]
      expect(actual).to eq(test_hash)
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
