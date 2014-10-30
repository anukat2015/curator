class CreateCompanyReportsByReturnOnCapital < ActiveRecord::Migration
  def change
    create_table :company_reports_by_return_on_capital do |t|
      t.string :name
      t.string :symbol
      t.string :ebit
      t.string :ebit_date
      t.string :market_cap
      t.string :market_cap_date
      t.string :working_capital
      t.string :working_capital_date
      t.string :total_assets
      t.string :total_assets_date
      t.string :current_assets
      t.string :current_assets_date
      t.string :total_debt
      t.string :total_debt_date
      t.string :cash_and_equivalents
      t.string :cash_and_equivalents_date
      t.string :fixed_assets
      t.string :enterprise_value
      t.string :earnings_yield
      t.string :return_on_capital

      t.timestamps
    end
  end
end
