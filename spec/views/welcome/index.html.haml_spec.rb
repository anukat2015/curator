require 'rails_helper'

RSpec.describe "welcome/index", :type => :view  do
  it "displays reports" do
    assign(:reports, [
      (Report.new(
        :symbol => "AAPL",
        :return_on_capital => 0.1,
        :earnings_yield => 0.2)),
      (Report.new(
        :symbol => "GOOG",
        :return_on_capital => 0.1,
        :earnings_yield => 0.2))
    ])
    assign(:last_updated, Date.today)

    render

    expect(rendered).to include("AAPL")
    expect(rendered).to include("GOOG")
  end
end
