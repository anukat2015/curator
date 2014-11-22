class DataFactory
  attr_reader :ticker_array

  def initialize(ticker_array:)
    @ticker_array = ticker_array
  end

  def make_company_hashes
    ticker_array.map do |ticker|
      ey = DataWorker.new(ticker: ticker, type: :ey).get_ey_and_roc
      roc = DataWorker.new(ticker: ticker, type: :roc).get_ey_and_roc
      puts "Done with #{ticker} No. #{ticker_array.index(ticker)}"
      ey.merge(roc) if ey && roc
    end
  end
end
