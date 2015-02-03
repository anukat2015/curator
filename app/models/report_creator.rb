class ReportCreator
  def create_company_reports
    dat = data.deep_dup
    dat.each do |company|
      Report.create(company.each { |k,v| company[k] = v.to_s })
    end
  end

  private

  attr_reader :data

  def initialize(data:)
    @data = data
  end
end
