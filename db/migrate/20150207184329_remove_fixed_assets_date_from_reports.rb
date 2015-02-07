class RemoveFixedAssetsDateFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :fixed_assets_date
  end
end
