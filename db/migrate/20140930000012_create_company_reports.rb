class CreateCompanyReports < ActiveRecord::Migration
  def change
    create_table :company_reports do |t|
      t.string :name
      t.string :symbol
      t.string :ebitda
      t.string :market_cap
      t.string :eps
      t.string :book_value

      t.timestamps
    end
  end
end
