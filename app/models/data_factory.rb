class DataFactory
  def make_company_hashes
    ticker_array.map do |ticker|
      ey = DataWorker.new(ticker: ticker, type: :ey).get_ey_and_roc
      roc = DataWorker.new(ticker: ticker, type: :roc).get_ey_and_roc
      warn "Earnings Yield retrieval for #{ticker} has failed." unless ey
      warn "Return on Capital retrieval for #{ticker} has failed." unless roc
      puts "Done with #{ticker} No. #{ticker_array.index(ticker) + 1}" if ey && roc
      ey.merge(roc) if ey && roc
    end
  end

  private

  attr_reader :ticker_array

  def initialize(ticker_array:)
    @ticker_array = ticker_array
  end
end
