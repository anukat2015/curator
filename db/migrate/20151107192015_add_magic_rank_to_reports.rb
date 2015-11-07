class AddMagicRankToReports < ActiveRecord::Migration
  def change
    add_column :reports, :magic_rank, :integer
  end
end
