class FrequentPerMinTerm < ActiveRecord::Base
  belongs_to :term
  belongs_to :per_min

  #FrequentPerMinTerm.find(:first, :conditions => "per_min_id = '#{}' AND term_id = '#{}'")

  scope :find_frequent_per_min_term, lambda { |per_min_id, term_id| {
    :conditions => ["per_min_id = ? AND term_id = ?", per_min_id, term_id]
  } }

end
