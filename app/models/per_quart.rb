class PerQuart < ActiveRecord::Base
  has_many :twitter_trend
  belongs_to :twitter_trend_term
end
