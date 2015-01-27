class AddAttributesToReports < ActiveRecord::Migration
  def change
    add_column :reports, :name, :string
    add_column :reports, :symbol, :string
    add_column :reports, :ebit, :float
    add_column :reports, :ebit_date, :string
    add_column :reports, :market_cap, :float
    add_column :reports, :market_cap_date, :string
    add_column :reports, :working_capital, :float
    add_column :reports, :working_capital_date, :string
    add_column :reports, :fixed_assets, :float
    add_column :reports, :fixed_assets_date, :string
    add_column :reports, :total_assets, :float
    add_column :reports, :total_assets_date, :string
    add_column :reports, :current_assets, :float
    add_column :reports, :current_assets_date, :string
    add_column :reports, :total_debt, :float
    add_column :reports, :total_debt_date, :string
    add_column :reports, :cash_and_equivalents, :float
    add_column :reports, :cash_and_equivalents_date, :string
    add_column :reports, :enterprise_value, :float
    add_column :reports, :return_on_capital, :float
    add_column :reports, :earnings_yield, :float
  end
end
