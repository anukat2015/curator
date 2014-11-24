desc "This task runs the curator app!"
task :curate => :environment do
  Custodian.new(file: "russell3000.txt", num_to_keep: 50).curate
end
