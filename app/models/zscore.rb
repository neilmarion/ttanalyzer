class Zscore < ActiveRecord::Base
  belongs_to :per_min
  belongs_to :term

  scope :find_zscore_per_min_per_term, lambda { |per_min_id, per_term_id| {
    :conditions => ["per_min_id = ? AND term_id = ?", per_min_id, per_term_id]
  } }
end
