class ZscoreSumPerFiveMin < ActiveRecord::Base
  belongs_to :term

  scope :top_ten_in_five_mins, lambda { {
    :order => ["zscore_sum/5 DESC"],
    :limit => ["0,10"]
  } }

  scope :distinct_terms, lambda { {
    :select => ["term_id"]
  } }
end
