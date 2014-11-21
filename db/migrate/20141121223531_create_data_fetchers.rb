class CreateDataFetchers < ActiveRecord::Migration
  def change
    create_table :data_fetchers do |t|

      t.timestamps
    end
  end
end
