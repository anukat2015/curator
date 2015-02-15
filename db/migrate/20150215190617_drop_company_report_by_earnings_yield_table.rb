class DropCompanyReportByEarningsYieldTable < ActiveRecord::Migration
  def change
    drop_table :company_reports_by_earnings_yield
  end
end
