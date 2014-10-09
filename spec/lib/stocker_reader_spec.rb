require 'spec_helper'
require 'stock_reader'

RSpec.describe StockReader do
  describe 'adder' do
    it 'returns the sum of its arguments' do
      expect(StockReader.adder(1,2)).to eq(3)
    end
  end
end
