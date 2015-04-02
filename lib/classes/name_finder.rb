class NameFinder
  def get_company_names
    update_names(company_names)
  end

  private

  def initialize(file:)
    @file = file
  end

  attr_reader :file

  def update_names(names)
    names.each do |ticker, company_name|
      report = Report.find_by(symbol: ticker)
      report.update(name: company_name) if report
    end
  end

  def company_names
    File.readlines(file).each_with_object({}) do |line, hash|
      partitioned_name = line.partition(/\b(\S+)$/)
      company_name = partitioned_name[0].strip
      ticker = partitioned_name[1]
      hash[ticker] = company_name
    end
  end
end
