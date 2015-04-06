require 'csv'

class Clerk
  include ActionView::Helpers::NumberHelper

  def create_csv
    CSV.open("#{file_name}.csv", "wb") do |csv|
      csv << attrs.map { |attr| attr.to_s.capitalize.gsub("_", " ") }
      reports.each do |report|
        report_info = []
        attrs.each do |attr|
          case attr
          when :symbol
            report_info << report.symbol
          when :name
            report_info << report.name
          when :return_on_capital
            report_info << number_to_percentage(report.return_on_capital * 100, precision: 3)
          when :earnings_yield
            report_info << number_to_percentage(report.earnings_yield * 100,    precision: 3)
          when :enterprise_value
            report_info << number_to_currency(report.enterprise_value,          precision: 0)
          when :ebit
            report_info << number_to_currency(report.ebit,                      precision: 0)
          when :market_cap
            report_info << number_to_human(report.market_cap)
          when :working_capital
            report_info << number_to_currency(report.working_capital,           precision: 0)
          when :fixed_assets
            report_info << number_to_currency(report.fixed_assets,              precision: 0)
          when :total_assets
            report_info << number_to_currency(report.total_assets,              precision: 0)
          when :current_assets
            report_info << number_to_currency(report.current_assets,            precision: 0)
          when :total_debt
            report_info << number_to_currency(report.total_debt,                precision: 0)
          when :cash_and_equivalents
            report_info << number_to_currency(report.cash_and_equivalents,      precision: 0)
          end
        end
        csv << report_info
      end

    end
  end

  private

  attr_reader :params, :attrs, :file_name

  def initialize(params:, attributes:, file_name:)
    @params = params
    @attrs = attributes
    @file_name = file_name
  end

  def reports
    Report.order(params["sort_by"].intern => :desc).limit(params["limit"].to_i)
  end
end
