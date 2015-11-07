require "rails_helper"

describe MagicRanker do
  describe ".rank_reports" do
    before { Report.delete_all }

    subject { -> { MagicRanker.rank_reports } }

    let!(:report1) { Report.create!(earnings_yield: 0.1, return_on_capital: 0.2, market_cap: 10, symbol: "A") }
    let!(:report2) { Report.create!(earnings_yield: 0.2, return_on_capital: 0.4, market_cap: 20, symbol: "B") }
    let!(:report3) { Report.create!(earnings_yield: 0.3, return_on_capital: 0.1, market_cap: 30, symbol: "C") }
    let!(:report4) { Report.create!(earnings_yield: 0.7, return_on_capital: 0.3, market_cap: 40, symbol: "D") }

    it "assigns a quality rank based on return on capital" do
      subject.call
      expect(Report.order(:quality_rank).to_a).to eq([report2, report4, report1, report3])
    end

    it "assigns a value rank based on earnings yield" do
      subject.call
      expect(Report.order(:value_rank).to_a).to eq([report4, report3, report2, report1])
    end

    it "assigns a magic number - sum of value and quality ranks" do
      subject.call
      expect(Report.order(:id).map(&:magic_number)).to eq([7,4,6,3])
    end

    it "assigns a magic rank based on magic number" do
      subject.call
      expect(Report.order(:magic_rank).to_a).to eq([report4, report2, report3, report1])
    end

    after(:all) { Report.delete_all }
  end
end
