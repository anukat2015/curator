class AddValueRankToReports < ActiveRecord::Migration
  def change
    add_column :reports, :value_rank, :integer
  end
end
