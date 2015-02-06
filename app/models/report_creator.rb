class ReportCreator
  def create_company_reports
    company_data = data.deep_dup
    company_data.each do |company|
      Report.create(company.each { |k,v| company[k] = v.to_s })
    end
  end

  private

  attr_reader :data

  def initialize(data:)
    @data = data
  end
end
