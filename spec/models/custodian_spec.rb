require 'rails_helper'
require 'date'
require 'csv'
require 'sample_data'

RSpec.describe Custodian do

  describe '#curate' do
    before(:all) do
      CompanyReportByEarningsYield.delete_all
      CompanyReportByReturnOnCapital.delete_all
      Report.delete_all
      Custodian.new(file: "spec/russell5.txt", num_to_keep: 5).curate
    end

    it 'creates reports' do
      expect(Report.count).to eq(4)
    end
  end
end
