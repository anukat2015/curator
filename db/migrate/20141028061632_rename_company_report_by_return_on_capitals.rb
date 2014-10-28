class RenameCompanyReportByReturnOnCapitals < ActiveRecord::Migration
  def change
    rename_table :company_report_by_return_on_capitals, :company_report_by_return_on_capital
  end
end
