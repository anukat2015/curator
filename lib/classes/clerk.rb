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

  attr_reader :params, :file_name

  def initialize(params:, file_name:)
    @params = params
    @file_name = file_name
  end
end
