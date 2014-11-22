class Sorter
  attr_reader :data, :metric, :num_to_keep

  def initialize(data:, metric:, num_to_keep:)
    @data = data
    @metric = metric
    @num_to_keep = num_to_keep
  end

  def sort_company_data
  end
end
