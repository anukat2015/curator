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

      expect(report.symbol).to eq(sample_company_data_1[:symbol])

      expect(report.ebit).to eq(sample_company_data_1[:ebit])
      expect(report.ebit_date).to eq(sample_company_data_1[:ebit_date])

      expect(report.market_cap).to eq(sample_company_data_1[:market_cap])
      expect(report.market_cap_date).to eq(sample_company_data_1[:market_cap_date])

      expect(report.working_capital).to eq(sample_company_data_1[:working_capital])
      expect(report.working_capital_date).to eq(sample_company_data_1[:working_capital_date])

      expect(report.fixed_assets).to eq(sample_company_data_1[:fixed_assets])

      expect(report.total_assets).to eq(sample_company_data_1[:total_assets])
      expect(report.total_assets_date).to eq(sample_company_data_1[:total_assets_date])

      expect(report.current_assets).to eq(sample_company_data_1[:current_assets])
      expect(report.current_assets_date).to eq(sample_company_data_1[:current_assets_date])

      expect(report.total_debt).to eq(sample_company_data_1[:total_debt])
      expect(report.total_debt_date).to eq(sample_company_data_1[:total_debt_date])

      expect(report.cash_and_equivalents).to eq(sample_company_data_1[:cash_and_equivalents])
      expect(report.cash_and_equivalents_date).to eq(sample_company_data_1[:cash_and_equivalents_date])

      expect(report.enterprise_value).to eq(sample_company_data_1[:enterprise_value])
      expect(report.earnings_yield).to eq(sample_company_data_1[:earnings_yield])
      expect(report.return_on_capital).to eq(sample_company_data_1[:return_on_capital])
    end
  end
end
