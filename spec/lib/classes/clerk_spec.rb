require 'rails_helper'
require 'sample_data'

RSpec.describe Clerk do
  describe '#create_csv' do
    before(:all) do
      Report.delete_all
    end

    it 'creates csv files' do
      Clerk.new(params: {}, file_name: "company_report").create_csv
      expect(File.file?("company_report.csv")).to be true
    end

    it 'creates CSVs based on passed parameters' do
      report_params = {
        "sort_by" => "return_on_capital",
        "limit" => "2"
      }

      Report.create(name: "Acme Co", return_on_capital: 20)
      Report.create(name: "Fake Co", return_on_capital: 10)

      attributes = [:name, :return_on_capital]

      Clerk.new(
        params: report_params,
        attributes: attributes,
        file_name: "download.csv"
      ).create_csv

      csv_arr = [
        ["Name", "Return On Capital"],
        ["Acme Co", 20],
        ["Fake Co", 10]
      ]

      expected = CSV.read("download.csv")

      expect(csv_arr).to eq(expected)
    end

    after(:all) do
      File.delete("company_report.csv")
      File.delete("download.csv")
    end
  end
end
