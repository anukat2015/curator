require 'rails_helper'
require 'sample_data'

RSpec.describe DataWorker do
  describe '#get_ey_and_roc' do
    it 'amalgamates data correctly' do
      ticker = 'AAPL'
      ey_data = DataWorker.new(ticker: ticker, type: :ey).get_ey_and_roc
      roc_data =  DataWorker.new(ticker: ticker, type: :roc).get_ey_and_roc

      expect(ey_data).to eq(earnings_yield_data_1)
      expect(roc_data).to eq(return_on_capital_data_1)
    end
  end
end
