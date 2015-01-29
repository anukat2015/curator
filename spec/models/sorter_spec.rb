require 'rails_helper'
require 'sample_data'

RSpec.describe Sorter do
  describe '#sort_company_data' do
    it 'sorts by the given metric' do
      company_data = [earnings_yield_data_1, earnings_yield_data_2]
      actual = Sorter.new(data: company_data, metric: :earnings_yield, num_to_keep: 30).sort_company_data
      expect(actual).to eq(company_data)
    end
  end
end
