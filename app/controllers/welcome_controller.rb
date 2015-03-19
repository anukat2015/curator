class WelcomeController < ApplicationController
  def index
    if !report_params.blank?
      @reports = Report.order(report_params[:sort_by] => :desc)
                       .limit(report_params[:limit].to_i)
      @message = MessageMaker.new(report_params).make_message
    end
    @last_updated = Report.maximum("updated_at").to_date.to_s
  end

  private

  def report_params
    params.permit(:sort_by, :limit)
  end
end
