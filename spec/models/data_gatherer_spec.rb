require 'rails_helper'

RSpec.describe DataGatherer do
  before(:all) do
    Report.delete_all
  end

  describe '.initialize' do
    it 'accepts a file' do
      expect { DataGatherer.new(file: "russell3000.txt") }.not_to raise_error
    end
  end

  describe '#gather_data' do
    it 'gathers and persists data' do
      DataGatherer.new(file: "russell5.txt").gather_data
      report = Report.first
      expect(report.symbol).to eq("TESS")
      expect(report.ebit).to eq(2684100.0)
    end
  end
end
