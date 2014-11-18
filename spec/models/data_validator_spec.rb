require 'rails_helper'

RSpec.describe DataValidator, :type => :model do
  describe '#data_present?' do
    it 'returns true if data is present' do
      actual = DataValidator.new('AAPL').data_present?
      expect(actual).to be(true)
    end
  end
end
