require 'rails_helper'

RSpec.describe DataGatherer do
  describe '.initialize' do
    it 'accepts a file' do
      expect { DataGatherer.new(file: "russell3000.txt") }.not_to raise_error
    end
  end
end
