class ZscoreCurrent < ActiveRecord::Base
  belongs_to :term

  scope :top_20,  lambda { {
    :order => "zscore DESC",
    :limit => 20
  } }
end
