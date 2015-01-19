class WelcomeController < ApplicationController
  def index
    @ey_reports = CompanyReportByEarningsYield.all
    @roc_reports = CompanyReportByReturnOnCapital.all
  end
end
