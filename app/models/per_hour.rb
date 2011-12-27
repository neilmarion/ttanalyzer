class PerHour < ActiveRecord::Base
  has_many :zscore_ave_per_hour
  has_many :per_min
  has_many :per_five_min
end
