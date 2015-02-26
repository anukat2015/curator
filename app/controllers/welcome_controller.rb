class WelcomeController < ApplicationController
  def index
    @reports = Report.select(:symbol, :return_on_capital, :earnings_yield)
                       .order(report_params[:sort_by] => :desc)
  end

  private

  def report_params
    params.permit(:sort_by, :limit)
  end
end
