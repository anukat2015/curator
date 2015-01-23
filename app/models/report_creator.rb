class ReportCreator
  def create_company_reports
    dat = data.deep_dup
    dat.each do |company|
      type.create(company.each { |k,v| company[k] = v.to_s })
    end
  end

  private

  attr_reader :data, :type

  def initialize(data:, type:)
    @data = data
    @type = type
  end
end
