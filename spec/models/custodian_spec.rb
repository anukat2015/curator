require 'rails_helper'

RSpec.describe Custodian do

  describe '#curate' do
    before(:all) do
      Report.delete_all
      Custodian.new(file: "spec/russell5.txt", num_to_keep: 5).curate
    end

    it 'creates reports' do
      expect(Report.count).to eq(4)
    end
  end
end
