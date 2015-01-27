require 'rails_helper'
require 'sample_data'

RSpec.describe ReportCreator do
  describe '#create_company_reports' do
    before(:all) do
      CompanyReportByEarningsYield.delete_all
      CompanyReportByReturnOnCapital.delete_all
    end

    it 'creates earnings yield reports' do
      earnings_yield_array = [earnings_yield_data_1, earnings_yield_data_2]
      ReportCreator.new(data: earnings_yield_array, type: CompanyReportByEarningsYield).create_company_reports
      expect(CompanyReportByEarningsYield.count).to eq(2)
    end

    it 'creates return on capital reports' do
      return_on_capital_array = [return_on_capital_data_1, return_on_capital_data_2]
      ReportCreator.new(data: return_on_capital_array, type: CompanyReportByReturnOnCapital).create_company_reports
      expect(CompanyReportByReturnOnCapital.count).to eq(2)
    end
  end
end
