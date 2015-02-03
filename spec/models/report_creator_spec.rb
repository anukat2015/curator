require 'rails_helper'
require 'sample_data'

RSpec.describe ReportCreator do
  describe '#create_company_reports' do
    before(:all) do
      Report.delete_all
    end

    it 'creates reports' do
      company_data_array = [sample_company_data]
      ReportCreator.new(data: company_data_array, type: Report).create_company_reports
      expect(Report.count).to eq(1)
    end
  end
end
