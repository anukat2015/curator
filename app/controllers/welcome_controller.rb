class WelcomeController < ApplicationController
  def index
    unless report_params.blank?
      @reports = report_list(report_params[:sort_by], report_params[:limit])
      @message = MessageMaker.new(report_params).make_message
      @download_link = "<a href='/download'>Download CSV</a>"
      session[:report_params] = report_params
    end
    @last_updated = Report.maximum(:updated_at).to_date
  end

  def download_csv
    generate_csv
    send_data File.read(csv_filename),
              filename: csv_filename.split("/").last,
              type: "csv"
    delete_csv
  end

  private

  def report_list(sort_by, limit)
    if sort_by == "magic_rank"
      Report.order(sort_by).limit(limit.to_i)
    else
      Report.order(sort_by => :desc).limit(limit.to_i)
    end
  end

  def report_params
    params.permit(:sort_by, :limit)
  end

  def saved_params
    session[:report_params]
  end

  def generate_csv
    attrs = %i(
      symbol
      name
      magic_rank
      magic_number
      quality_rank
      value_rank
      return_on_capital
      earnings_yield
      enterprise_value
      ebit
      ebit_date
      market_cap
      market_cap_date
      working_capital
      working_capital_date
      fixed_assets
      total_assets
      total_assets_date
      current_assets
      current_assets_date
      total_debt
      total_debt_date
      cash_and_equivalents
      cash_and_equivalents_date
    )

    Clerk.new(
      params: saved_params,
      attributes: attrs,
      file_name: csv_filename
    ).create_csv
  end

  def csv_filename
    "#{Rails.root}/public/Curator Output #{Time.now.to_s.split.first}.csv"
  end

  def delete_csv
    File.delete(csv_filename) if File.file?(csv_filename)
  end
end
