class AddColumnsToCompanyReports < ActiveRecord::Migration
  def change
    add_column :company_reports, :market_cap_date, :string
    add_column :company_reports, :total_assets, :string
    add_column :company_reports, :total_assets_date, :string
    add_column :company_reports, :current_assets, :string
    add_column :company_reports, :current_assets_date, :string
    add_column :company_reports, :total_debt, :string
    add_column :company_reports, :total_debt_date, :string
    add_column :company_reports, :cash_and_equivalents, :string
    add_column :company_reports, :cash_and_equivalents_date, :string
    add_column :company_reports, :working_capital_date, :string
  end
end
