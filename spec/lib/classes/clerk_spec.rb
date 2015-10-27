require 'rails_helper'
require 'sample_data'

RSpec.describe Clerk do
  describe '#create_csv' do
    before(:all) do
      Report.delete_all
    end

    it 'creates csv files' do
      report_params = {
        "sort_by" => "return_on_capital",
        "limit" => "2"
      }

      Clerk.new(params: report_params, attributes: [], file_name: "company_report.csv").create_csv
      expect(File.file?("company_report.csv")).to be(true)
    end

    it 'creates CSVs based on passed parameters' do
      report_params = {
        "sort_by" => "return_on_capital",
        "limit" => "2"
      }

      Report.create!(name: "Acme Co", symbol: "ACME", return_on_capital: 0.5)
      Report.create!(name: "Fake Co", symbol:"FCO", return_on_capital: 0.1)

      attributes = [:name, :symbol, :return_on_capital]

      Clerk.new(
        params: report_params,
        attributes: attributes,
        file_name: "download.csv"
      ).create_csv

      expected = [
        ["Name", "Symbol", "Return on capital"],
        ["Acme Co", "ACME", "50.000%"],
        ["Fake Co", "FCO", "10.000%"]
      ]

      expect(CSV.read("download.csv")).to eq(expected)
    end

    after(:all) do
      File.delete("company_report.csv")
      File.delete("download.csv")
    end
  end
end
