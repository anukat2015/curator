require 'rails_helper'

RSpec.describe DataFetcher do
  describe '#get_company_data' do
    it 'retrieves data for calculating earnings yield' do
      ticker = 'AAPL'
      ey_hash = {:market_cap => "MARKETCAP", :cash => "CASHNEQ_MRQ", :debt => "DEBT_MRQ"}
      ey_data = DataFetcher.new(ticker: ticker, query_hash: ey_hash).get_company_data
      expect(ey_data[:market_cap]["data"].flatten[1]).to be_kind_of(Float)
      expect(ey_data[:cash]["data"].flatten[1]).to be_kind_of(Float)
      expect(ey_data[:debt]["data"].flatten[1]).to be_kind_of(Float)
    end

    it 'retrieves data for calculating return on capital' do
      ticker = 'AAPL'
      roc_hash = {:total_assets => "ASSETS_MRQ", :current_assets => "ASSETSC_MRQ", :working_capital => "WORKINGCAPITAL_MRQ"}
      roc_data = DataFetcher.new(ticker: ticker, query_hash: roc_hash).get_company_data
      expect(roc_data[:total_assets]["data"].flatten[1]).to be_kind_of(Float)
      expect(roc_data[:current_assets]["data"].flatten[1]).to be_kind_of(Float)
      expect(roc_data[:working_capital]["data"].flatten[1]).to be_kind_of(Float)
    end
  end
end
