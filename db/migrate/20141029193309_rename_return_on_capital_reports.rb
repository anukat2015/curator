class RenameReturnOnCapitalReports < ActiveRecord::Migration
  def change
    rename_table :company_report_by_return_on_capital, :company_reports_by_return_on_capital
  end
end
