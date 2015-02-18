require 'rails_helper'

RSpec.describe Report, :type => :model do
  it 'can be created' do
    report = Report.create!
    expect(report).to be_an_instance_of(Report)
  end

  it 'accepts the necessary attributes' do
    report = Report.create!(
      name: 'Acme Corporation',
      symbol: 'ACME',
      ebit: 123456789.101,
      ebit_date: '2000-01-01',
      market_cap: 123456789.101,
      market_cap_date: '2000-01-01',
      working_capital: 123456789.101,
      working_capital_date: '2000-01-01',
      fixed_assets: 123456789.101,
      total_assets: 123456789.101,
      total_assets_date: '2000-01-01',
      current_assets: 123456789.101,
      current_assets_date: '2000-01-01',
      total_debt: 123456789.101,
      total_debt_date: '2000-01-01',
      cash_and_equivalents: 123456789.101,
      cash_and_equivalents_date: '2000-01-01',
      enterprise_value: 123456789.101,
      return_on_capital: 0.2,
      earnings_yield: 0.2
    )
  end

  after(:all) do
    Report.delete_all
  end
end
