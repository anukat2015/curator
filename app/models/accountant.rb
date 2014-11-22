class Accountant
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  def calculate_ey_and_roc
    if data[:market_cap]
      data[:enterprise_value] = (data[:market_cap] + data[:total_debt]) - data[:cash_and_equivalents]
      data[:earnings_yield] = data[:ebit] / data[:enterprise_value]
    elsif data[:total_assets] && data[:current_assets]
      net_fixed_assets = data[:total_assets] - data[:current_assets]
      data[:return_on_capital] = data[:ebit] / (net_fixed_assets + data[:working_capital])
    end
    data
  end
end
