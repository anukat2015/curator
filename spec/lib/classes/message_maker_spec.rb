require "rails_helper"

RSpec.describe MessageMaker do
  describe '#make_message' do
    it 'works with return_on_capital as a parameter' do
      params = { :sort_by => "return_on_capital", :limit => 10 }

      msg = MessageMaker.new(params).make_message

      expect(msg).to eq("Sorting by Return on Capital\nLimit: 10")
    end

    it 'works with earnings_yield as a parameter' do
      params = { :sort_by => "earnings_yield", :limit => 100 }

      msg = MessageMaker.new(params).make_message

      expect(msg).to eq("Sorting by Earnings Yield\nLimit: 100")
    end


    it 'interprets 2000 as a limit of none' do
      params = { :sort_by => "return_on_capital", :limit => "3000" }

      msg = MessageMaker.new(params).make_message

      expect(msg).to eq("Sorting by Return on Capital\nLimit: None")
    end

    it 'works with nil parameters' do
      params = { :sort_by => nil, :limit => nil }

      msg = MessageMaker.new(params).make_message

      expect(msg).to eq("Sorting by nothing\nLimit: None")
    end

    it 'works with empty parameters' do
      params = {}

      msg = MessageMaker.new(params).make_message

      expect(msg).to eq("Sorting by nothing\nLimit: None")
    end

  end
end
