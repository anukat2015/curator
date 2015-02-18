class Accountant
  def calculate_ey_and_roc
    if data[:market_cap]
      data[:enterprise_value] = (data[:market_cap] + data[:total_debt]) - data[:cash_and_equivalents]
      data[:earnings_yield] = (data[:ebit] / data[:enterprise_value]).round(6)
    elsif data[:total_assets] && data[:current_assets]
      data[:fixed_assets] = data[:total_assets] - data[:current_assets]
      data[:return_on_capital] = (data[:ebit] / (data[:fixed_assets] + data[:working_capital])).round(6)
    end
    data
  end

  private

  def initialize(data:)
    @data = data
  end

  attr_reader :data
end
