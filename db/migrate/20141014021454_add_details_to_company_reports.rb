class AddDetailsToCompanyReports < ActiveRecord::Migration
  def change
    add_column :company_reports, :ebit, :string
    add_column :company_reports, :ebit_date, :string
    add_column :company_reports, :enterprise_value, :string
    add_column :company_reports, :enterprise_value_date, :string
    add_column :company_reports, :earnings_yield, :string
    add_column :company_reports, :fixed_assets, :string
    add_column :company_reports, :working_capital, :string
    add_column :company_reports, :return_on_capital, :string
  end
end
