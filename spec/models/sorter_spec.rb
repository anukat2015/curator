require 'rails_helper'
require 'sample_data'

RSpec.describe Sorter do
  describe '#sort_company_data' do
    it 'sorts correctly by earnings yield' do
      company_data = [sample_company_data_1, sample_company_data_3, sample_company_data_2]

      actual = Sorter.new(data: company_data, metric: :earnings_yield, num_to_keep: 30).sort_company_data

      expected = [sample_company_data_2, sample_company_data_3, sample_company_data_1]
      expect(actual).to eq(expected)
    end
  end
end
