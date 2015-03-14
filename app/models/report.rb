class Report < ActiveRecord::Base
  validates_uniqueness_of :symbol
end
