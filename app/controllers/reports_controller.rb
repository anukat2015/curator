class ReportsController < ApplicationController
  def download_csv
  end

  def get_reports
    Overseer.new(ticker_file: "russell3000.txt").retrieve_and_persist_data
  end
end
