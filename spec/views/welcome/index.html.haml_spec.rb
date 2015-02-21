require 'rails_helper'

RSpec.describe "welcome/index", :type => :view  do
  it "displays reports" do
    assign(:reports, [
      (Report.new(:symbol => "AAPL")),
      (Report.new(:symbol => "GOOG"))
    ])

    render

    expect(rendered).to include("AAPL")
    expect(rendered).to include("GOOG")
  end
end
