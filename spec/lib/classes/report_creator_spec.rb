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
      report.attributes.each do |attr_name, attr_value|
        next if ['id', 'created_at', 'updated_at'].include? attr_name
        expect(report[attr_name.to_sym]).to eq(sample_company_data_1[attr_name.to_sym])
      end
    end

    it 'does not create duplicate reports' do
      2.times { ReportCreator.new(data: sample_company_data_array).create_company_reports }
      expect(Report.all.count).to eq(sample_company_data_array.length + 1)
    end
  end
end
