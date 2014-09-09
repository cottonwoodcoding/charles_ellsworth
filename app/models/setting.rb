class Setting < ActiveRecord::Base
  attr_accessible :key, :value
  validates_uniqueness_of :key
end
