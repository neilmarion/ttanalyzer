class Term < ActiveRecord::Base
  has_many :frequent_per_min_term
  has_many :zscores
  has_one :zscore_historical
  has_one :zscore_current

  scope :order_by_current_zscore, lambda { {
    :joins => :zscore_current,
    :order => "zscore DESC"
  } }
end
