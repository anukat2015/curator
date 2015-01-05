require 'rails_helper'
require 'sample_data'

RSpec.describe Clerk, :type => :model do
  describe '#create_csv' do

    it 'creates csv files' do
      return_on_capital_array = [return_on_capital_data_1, return_on_capital_data_2]
      Clerk.new(data: return_on_capital_array, file_name: "company_report").create_csv
      expect(File.file?("company_report.csv")).to be(true)
    end

    after(:all) do
      File.delete("company_report.csv")
    end
  end
end
