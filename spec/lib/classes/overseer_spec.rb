require 'rails_helper'

RSpec.describe Overseer do
  describe '#retrieve_and_persist_data' do
    before(:all) do
      Report.delete_all
    end

    it 'retrieves and persists data correctly' do
      Overseer.new(ticker_file: "spec/russell5.txt").retrieve_and_persist_data
      report = Report.first

      expect(Report.all.count).to eq(5)
      expect(report.symbol).to eq("TESS")
      expect(report.ebit).to eq(2684100.0)
    end
  end
end
