class ZscoreTrendsPerFiveMinReport < ActiveRecord::Base
  belongs_to :term
  belongs_to :per_five_min

  scope :find_per_five_min_per_term, lambda { |per_five_min_id, term_id| {
    :conditions => ["per_five_min_id = ? AND term_id = ?", per_five_min_id, term_id]
  } }
end
