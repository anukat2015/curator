require 'rails_helper'
require 'date'
require 'csv'
require 'sample_data'

RSpec.describe Custodian do

  describe '#curate' do
    before(:all) do
      CompanyReportByEarningsYield.delete_all
      CompanyReportByReturnOnCapital.delete_all
      Custodian.new(file: "spec/russell5.txt", num_to_keep: 5).curate
    end

    it 'creates reports' do
      expect(CompanyReportByEarningsYield.count).to eq(4)
      expect(CompanyReportByReturnOnCapital.count).to eq(4)
    end

    it 'creates CSV files' do
      expect(File.file?("Earnings Yield #{Date.today}.csv")).to be(true)
      expect(File.file?("Return on Capital #{Date.today}.csv")).to be(true)
    end

    it 'creates correct CSV files' do
      arr = CSV.read("Earnings Yield #{Date.today}.csv")
      expect(arr[0]).to eq(csv_columns)
      expect(arr[1]).to eq(csv_data_TSRA)

      arr = CSV.read("Return on Capital #{Date.today}.csv")
      expect(arr[0]).to eq(csv_columns)
      expect(arr[4]).to eq(csv_data_TTI)
    end

    after(:all) do
      File.delete("Earnings Yield #{Date.today}.csv")
      File.delete("Return on Capital #{Date.today}.csv")
    end
  end
end
