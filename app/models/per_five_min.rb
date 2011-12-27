class PerFiveMin < ActiveRecord::Base
  has_many :zscore_ave_per_five_min
  has_many :zscore_trends_per_five_min_report
  has_many :tt
  has_many :per_min

  belongs_to :per_hour
end
