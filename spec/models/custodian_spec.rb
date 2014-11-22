require 'rails_helper'
require 'date'

RSpec.describe Custodian, :type => :model do
  describe '#curate' do
    before(:all) do
      CompanyReportByEarningsYield.delete_all
      CompanyReportByReturnOnCapital.delete_all
    end

    it 'creates reports' do
      Custodian.new(file: "russell5.txt", num_to_keep: 3).curate
      expect(CompanyReportByEarningsYield.count).to eq(3)
      expect(CompanyReportByReturnOnCapital.count).to eq(3)
    end

    it 'creates CSV files' do
      expect(File.file?("Earnings Yield #{Date.today}.csv")).to be(true)
      expect(File.file?("Return on Capital #{Date.today}.csv")).to be(true)
    end

    it 'creates correct CSV files' do

    end

    # after(:all) do
    #   File.delete("Earnings Yield #{Date.today}")
    #   File.delete("Return on Capital #{Date.today}")
    # end
  end
end
