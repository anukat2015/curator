class WelcomeController < ApplicationController
  def index
    if !report_params.blank?
      @reports = Report.select(:symbol, :return_on_capital, :earnings_yield)
                       .order(report_params[:sort_by] => :desc)
                       .limit(report_params[:limit].to_i)

      @message = MessageMaker.new(report_params).make_message
    end
  end

  private

  def report_params
    params.permit(:sort_by, :limit)
  end
end
