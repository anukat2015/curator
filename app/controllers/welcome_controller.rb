class WelcomeController < ApplicationController
  def index
    if !report_params.blank?
      @reports = Report.select(:symbol, :return_on_capital, :earnings_yield)
                       .order(report_params[:sort_by] => :desc)
                       .limit(report_params[:limit].to_i)
      make_message(report_params[:sort_by], report_params[:limit])
    end
  end

  private

  def report_params
    params.permit(:sort_by, :limit)
  end

  def make_message(sort_by, limit)
    @message = "Sorting by "

    if sort_by == "return_on_capital"
      @message << "Return on Capital"
    elsif sort_by == "earnings_yield"
      @message << "Earnings Yield"
    else
      @message << "nothing"
    end

    if limit == "2000"
      @message << "\nLimit: None"
    else
      @message << "\nLimit: #{report_params[:limit]}"
    end
  end
end
