class Term < ActiveRecord::Base
  has_many :frequent_per_min_term
  has_many :zscores
  has_many :zscore_ave_per_5_min
  has_many :zscore_ave_per_hour
  has_one :zscore_historical
  has_one :zscore_current

  scope :order_by_current_zscore, lambda { {
    :joins => :zscore_current,
    :order => "zscore DESC"
  } }
end
