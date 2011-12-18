class PerFiveMin < ActiveRecord::Base
  has_many :zscore_ave_per_five_min
  has_many :tt
end
