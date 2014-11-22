require 'rails_helper'

RSpec.describe DataFetcher, :type => :model do
  describe '#get_company_data' do
    it 'retrieves data for calculating earnings yield' do
      ticker = 'AAPL'
      ey_hash = {:market_cap => "MARKETCAP", :cash => "CASHNEQ_MRQ", :debt => "DEBT_MRQ"}
      ey_data = DataFetcher.new(ticker: ticker, query_hash: ey_hash).get_company_data
      expect(ey_data[:market_cap]["data"].flatten[1]).to be_kind_of(Float)
      expect(ey_data[:cash]["data"].flatten[1]).to be_kind_of(Float)
      expect(ey_data[:debt]["data"].flatten[1]).to be_kind_of(Float)
    end
  end
end
