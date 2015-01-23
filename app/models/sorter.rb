class Sorter
  def sort_company_data
    data.reject! { |company| company.nil? || company[metric].nil? || company[metric].nan? }
    data.sort_by { |company| company[metric].to_f }.reverse.take(num_to_keep)
  end

  private

  attr_reader :data, :metric, :num_to_keep

  def initialize(data:, metric:, num_to_keep:)
    @data = data
    @metric = metric
    @num_to_keep = num_to_keep
  end
end
