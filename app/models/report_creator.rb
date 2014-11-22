class ReportCreator
  attr_reader :data, :type

  def initialize(data:, type:)
    @data = data
    @type = type
  end

  def create_company_reports
    data.each do |company|
      type.create(company.each { |k,v| company[k] = v.to_s })
    end
  end
end
