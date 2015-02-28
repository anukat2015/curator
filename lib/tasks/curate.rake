desc "This task retrieves and persists all necessary data from Quandl"
task :curate => :environment do
  Overseer.new(ticker_file: "russell3000.txt").retrieve_and_persist_data
end
