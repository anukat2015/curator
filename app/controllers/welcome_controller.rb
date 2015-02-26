class WelcomeController < ApplicationController
  def index
    @reports = Report.select(:symbol, :return_on_capital, :earnings_yield)
                     .order(report_params[:sort_by] => :desc)
                     .limit(report_params[:limit].to_i)
  end

  private

  def report_params
    params.permit(:sort_by, :limit)
  end
end
