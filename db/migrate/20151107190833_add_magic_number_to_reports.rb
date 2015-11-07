class AddMagicNumberToReports < ActiveRecord::Migration
  def change
    add_column :reports, :magic_number, :integer
  end
end
