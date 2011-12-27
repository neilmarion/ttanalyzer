class TtScore < ActiveRecord::Base
  belongs_to :tt_term

  scope :order_by_score_minutes, lambda { {
    :order => ["score*minutes DESC"]
  } }
end
