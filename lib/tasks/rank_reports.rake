desc "Adds value rank, quality rank, magic number, and magic rank to reports"
task rank_reports: :environment do
  MagicRanker.rank_reports
end
