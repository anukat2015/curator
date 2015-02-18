class Custodian
  def curate
  end

  private

  attr_reader :num_to_keep

  def initialize(num_to_keep:)
    @num_to_keep = num_to_keep
  end
end
