require 'rails_helper'

RSpec.describe Accountant do
  describe '#calculate_ey_and_roc' do
    it 'calculates correctly' do
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

      completed_ey_hash = Accountant.new(data: ey_hash).calculate_ey_and_roc
      completed_roc_hash = Accountant.new(data: roc_hash).calculate_ey_and_roc
      ev = (ey_hash[:market_cap] + ey_hash[:total_debt]) - ey_hash[:cash_and_equivalents]
      ey = ey_hash[:ebit] / ev
      net_fixed_assets = roc_hash[:total_assets] - roc_hash[:current_assets]
      roc = roc_hash[:ebit] / (net_fixed_assets + roc_hash[:working_capital])

      expect(completed_ey_hash[:enterprise_value]).to eq(ev)
      expect(completed_ey_hash[:earnings_yield]).to eq(ey)
      expect(completed_roc_hash[:fixed_assets]).to eq(net_fixed_assets)
      expect(completed_roc_hash[:return_on_capital]).to eq(roc)
    end
  end
end
