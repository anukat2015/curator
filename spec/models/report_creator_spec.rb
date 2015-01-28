require 'rails_helper'
require 'sample_data'

RSpec.describe ReportCreator do
  describe '#create_company_reports' do
    before(:all) do
      Report.delete_all
    end

    it 'creates reports' do
      earnings_yield_array = [earnings_yield_data_1, earnings_yield_data_2]
      ReportCreator.new(data: earnings_yield_array, type: Report).create_company_reports
      expect(Report.count).to eq(2)
    end
  end
end
