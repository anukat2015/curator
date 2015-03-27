require 'rails_helper'

RSpec.describe TickerExtractor do
  describe '#extract_tickers' do
    it 'extracts tickers properly' do
      extractor = TickerExtractor.new(ticker_file: 'spec/russell20.txt')
      expected = [
                  "FLWS",
                  "SRCE",
                  "FUBC",
                  "FOXA",
                  "XXII",
                  "TWOU",
                  "DDD",
                  "MMM",
                  "EGHT",
                  "AHC",
                  "AVHI",
                  "ATEN",
                  "AAON",
                  "AIR",
                  "AAN",
                  "ABAX",
                  "ABT",
                  "ABBV",
                  "ANF",
                  "ABMD"
                 ]

      expect(extractor.extract_tickers).to eq(expected)
    end
  end
end
