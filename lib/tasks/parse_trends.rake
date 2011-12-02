require 'rubygems'
require 'config/environment'

task :parse_trends do
  trend_file = File.open("tt/trend/current_trends.json")

  trends = JSON.parse(trend_file.gets)
  
  a = PerQuart.create
  position = 1

  trends[0]["trends"].each do |x|
    ttt = TwitterTrendTerm.find(:first, :conditions => ["term = ?", x["name"].upcase])
    puts x["name"]
    if ttt == nil
      tttnew = TwitterTrendTerm.create(:term => x["name"].upcase)
      TwitterTrend.create(:position => position, :twitter_trend_term_id => tttnew.id, :per_quart_id => a.id )
    else
      TwitterTrend.create(:position => position, :twitter_trend_term_id => ttt.id, :per_quart_id => a.id )
    end
    position = position + 1
  end

  
end
