class RenameCompanyReportsToCompanyReportsByEarningsYield < ActiveRecord::Migration
  def change
    rename_table :company_reports, :company_reports_by_earnings_yield
  end
end
