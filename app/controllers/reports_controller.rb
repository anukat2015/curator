class ReportsController < ApplicationController
  def get_reports
    Overseer.new(ticker_file: "russell3000.txt").retrieve_and_persist_data
  end
end
