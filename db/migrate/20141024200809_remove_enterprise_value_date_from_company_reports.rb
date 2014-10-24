class RemoveEnterpriseValueDateFromCompanyReports < ActiveRecord::Migration
  def change
    remove_column :company_reports, :enterprise_value_date, :string
  end
end
