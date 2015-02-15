class DropCompanyReportByReturnOnCapitalTable < ActiveRecord::Migration
  def change
    drop_table :company_reports_by_return_on_capital
  end
end
