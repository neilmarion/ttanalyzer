class ZscoreAvePerHour < ActiveRecord::Base
  belongs_to :per_hour
  belongs_to :term

  scope :find_zscore_ave_per_hour, lambda { |per_hour_id, term_id| {
    :conditions => ["per_hour_id = ? AND term_id = ?", per_hour_id, term_id]
  } }
end
