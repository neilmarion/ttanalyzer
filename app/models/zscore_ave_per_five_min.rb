class ZscoreAvePerFiveMin < ActiveRecord::Base
  belongs_to :per_five_min
  belongs_to :term

  scope :find_zscore_ave_per_five_min, lambda { |per_five_min_id, term_id| {
    :conditions => ["per_five_min_id = ? AND term_id = ?", per_five_min_id, term_id]
  } }
end
