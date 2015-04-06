class WelcomeController < ApplicationController
  def index
    if !report_params.blank?
      @reports = Report.order(report_params[:sort_by] => :desc)
                       .limit(report_params[:limit].to_i)
      @message = MessageMaker.new(report_params).make_message
    end
    @last_updated = Report.maximum("updated_at").to_date.to_s
  end

  def download_csv
    generate_csv
    send_file csv_filename
    delete_csv
  end

  private

  def report_params
    params.permit(:sort_by, :limit)
  end

  def generate_csv
    attrs = [
      :symbol,
      :name,
      :return_on_capital,
      :earnings_yield,
      :enterprise_value,
      :ebit,
      :market_cap,
      :working_capital,
      :fixed_assets,
      :total_assets,
      :current_assets,
      :total_debt,
      :cash_and_equivalents
    ]

    Clerk.new(
      params: report_params,
      attributes: attrs,
      file_name: csv_filename
    )
  end

  def csv_filename
    "#{Rails.root}/public/Curator Output #{Time.now.to_s.split.first}"
  end

  def delete_csv
    File.delete(csv_filename)
  end
end
