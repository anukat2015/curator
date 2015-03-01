class DataFactory
  def make_company_hashes
    ticker_array.map do |ticker|
      ey = DataWorker.new(ticker: ticker, type: :ey).get_ey_and_roc
      roc = DataWorker.new(ticker: ticker, type: :roc).get_ey_and_roc
      warn "Earnings Yield retrieval for #{ticker} has failed." unless ey
      warn "Return on Capital retrieval for #{ticker} has failed." unless roc

      if ey && roc
        puts "Done with #{ticker} No. #{ticker_array.index(ticker) + 1}"
        ey.merge(roc)
      end
    end
  end

  private

  def initialize(ticker_array:)
    @ticker_array = ticker_array
  end

  attr_reader :ticker_array
end
