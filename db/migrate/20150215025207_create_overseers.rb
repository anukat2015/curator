class CreateOverseers < ActiveRecord::Migration
  def change
    create_table :overseers do |t|

      t.timestamps
    end
  end
end
