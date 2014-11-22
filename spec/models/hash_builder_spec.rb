require 'rails_helper'

RSpec.describe HashBuilder, :type => :model do
  describe '#build_hash' do
    it 'returns a proper company hash object' do
      ticker = 'AAPL'
      ey_query_hash = {:ebit => "EBIT_MRQ", :market_cap => "MARKETCAP", :cash_and_equivalents => "CASHNEQ_MRQ", :total_debt => "DEBT_MRQ"}
      ey_data = DataFetcher.new(ticker: ticker, query_hash: ey_query_hash).get_company_data
      actual = HashBuilder.new(ticker: ticker, data: ey_data).build_hash
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
end
