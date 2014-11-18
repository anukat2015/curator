require 'rails_helper'

RSpec.describe DataValidator, :type => :model do
  describe '#data_present?' do
    it 'returns true if data is present' do
      actual = DataValidator.new('AAPL').data_present?
      expect(actual).to be(true)
    end

    it 'returns false if data is not present' do
      actual = DataValidator.new('NOTAREALTICKER').data_present?
      expect(actual).to be(false)
    end
  end
end
