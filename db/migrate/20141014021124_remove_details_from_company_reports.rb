class RemoveDetailsFromCompanyReports < ActiveRecord::Migration
  def change
    remove_column :company_reports, :ebitda, :string
    remove_column :company_reports, :book_value, :string
    remove_column :company_reports, :eps, :string
  end
end
