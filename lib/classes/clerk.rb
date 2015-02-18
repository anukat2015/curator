require 'csv'

class Clerk
  def create_csv
    CSV.open("#{file_name}.csv", "wb") do |csv|
      csv << data.first.map { |k, v| k.to_s.capitalize.gsub("_", " ") }
      data.each do |data|
        csv << data.each_value.map { |val| val.to_s }
      end
    end
  end

  private

  attr_reader :data, :file_name

  def initialize(data:, file_name:)
    @data = data
    @file_name = file_name
  end
end
