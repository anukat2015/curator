class ReportCreator
  def create_company_reports
    company_data = data.deep_dup
    company_data.each do |company|
      report = Report.find_or_initialize_by(symbol: company[:symbol])
      report.update_attributes!(company)
    end
  end

  private

  def initialize(data:)
    @data = data
  end

  attr_reader :data
end
