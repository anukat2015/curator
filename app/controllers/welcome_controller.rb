class WelcomeController < ApplicationController
  def index
    @ey_reports = CompanyReportByEarningsYield.all
  end
end
