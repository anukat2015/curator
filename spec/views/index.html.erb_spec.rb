require 'spec_helper'

describe "index.html.erb" do
  it "displays reports" do
    assign(:reports, [
      stub_model(Report, :symbol => "AAPL"),
      stub_model(Report, :symbol => "GOOG")
    ])

    render

    rendered.should contain("AAPL")
    rendered.should contain("GOOG")
  end
end
