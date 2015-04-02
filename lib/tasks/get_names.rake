desc "Retrieves company names"
task :get_names => :environment do
  NameFinder.new(file: "russell3000.txt").get_company_names
end
