require 'rails_helper'

RSpec.describe NameFinder do
  describe '#get_company_names' do
    before(:all) do
      Report.delete_all
      Report.create(symbol: "TESS")
      Report.create(symbol: "TTI")
    end

    it 'retrieves company names based on their symbols' do
      ticker_file_path = File.expand_path('spec/russell5.txt')
      NameFinder.new(file: ticker_file_path, ticker: 'TESS').get_company_names

      expect(Report.find_by(symbol: "TESS").name).to eq("TESSCO TECHNOLOGIES INC")
      expect(Report.find_by(symbol: "TTI").name).to eq("TETRA TECHNOLOGIES INC")
    end
  end
end
