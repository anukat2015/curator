require 'rails_helper'
require 'sample_data'

RSpec.describe ReportCreator do
  describe '#create_company_reports' do
    before(:all) do
      Report.delete_all
    end

    it 'creates reports' do
      company_data_array = [sample_company_data_1]
      ReportCreator.new(data: company_data_array).create_company_reports
      expect(Report.count).to eq(1)
    end

    it 'stores persists data correctly' do
      report = Report.first

      expect(report.symbol).to eq("AAPL")

      expect(report.ebit).to eq(24416000000.0)
      expect(report.ebit_date).to eq("2014-12-27")

      expect(report.market_cap).to eq(671651691880.0)
      expect(report.market_cap_date).to eq("2015-01-28")

      expect(report.working_capital).to eq(9792000000.0)
      expect(report.working_capital_date).to eq("2014-12-27")

      expect(report.fixed_assets).to eq(12345.0)

      expect(report.total_assets).to eq(261894000000.0)
      expect(report.total_assets_date).to eq("2014-12-27")

      expect(report.current_assets).to eq(83403000000.0)
      expect(report.current_assets_date).to eq("2014-12-27")

      expect(report.total_debt).to eq(36403000000.0)
      expect(report.total_debt_date).to eq("2014-12-27")

      expect(report.cash_and_equivalents).to eq(19478000000.0)
      expect(report.cash_and_equivalents_date).to eq("2014-12-27")

      expect(report.enterprise_value).to eq(688576691880.0)
      expect(report.earnings_yield).to eq(0.0354586501226722)
      expect(report.return_on_capital).to eq(0.129677134951111)
    end
  end
end
