require 'csv'

class Clerk
  include ActionView::Helpers::NumberHelper

  def create_csv
    CSV.open(file_name, "wb") do |csv|
      csv << attrs.map { |attr| attr.to_s.capitalize.gsub("_", " ") }

      reports.each do |report|
        report_info = []
        attrs.each do |attr|
          format_values(
            report: report,
            attribute: attr,
            container: report_info
          )
        end
        csv << report_info
      end

    end
  end

  private

  def initialize(params:, attributes:, file_name:)
    @params = params
    @attrs = attributes
    @file_name = file_name
  end

  attr_reader :params, :attrs, :file_name

  def reports
    Report.order(params["sort_by"].intern => :desc).limit(params["limit"].to_i)
  end

  def format_values(report:, attribute:, container:)
    case attribute
    when :symbol
      container << report.symbol
    when :name
      container << report.name
    when :return_on_capital
      container << number_to_percentage(report.return_on_capital * 100, precision: 3)
    when :earnings_yield
      container << number_to_percentage(report.earnings_yield * 100,    precision: 3)
    when :enterprise_value
      container << number_to_currency(report.enterprise_value,          precision: 0)
    when :ebit
      container << number_to_currency(report.ebit,                      precision: 0)
    when :market_cap
      container << number_to_currency(report.market_cap,                precision: 0)
    when :working_capital
      container << number_to_currency(report.working_capital,           precision: 0)
    when :fixed_assets
      container << number_to_currency(report.fixed_assets,              precision: 0)
    when :total_assets
      container << number_to_currency(report.total_assets,              precision: 0)
    when :current_assets
      container << number_to_currency(report.current_assets,            precision: 0)
    when :total_debt
      container << number_to_currency(report.total_debt,                precision: 0)
    when :cash_and_equivalents
      container << number_to_currency(report.cash_and_equivalents,      precision: 0)
    else
      container << report.send(attribute)
    end
  end
end
