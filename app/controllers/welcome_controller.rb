class WelcomeController < ApplicationController
  def index
    @reports = Report.where(params[:id])
  end
end
