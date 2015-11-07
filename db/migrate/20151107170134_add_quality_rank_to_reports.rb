class AddQualityRankToReports < ActiveRecord::Migration
  def change
    add_column :reports, :quality_rank, :integer
  end
end
