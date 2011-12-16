class PerMin < ActiveRecord::Base
  has_many :frequent_per_min_term
  has_many :per_min_stream_term_total
  has_many :per_min_stream_tweet_total



end
