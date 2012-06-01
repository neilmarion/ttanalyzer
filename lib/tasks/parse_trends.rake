require 'rubygems'
require 'config/environment'

task :parse_trends do
  trend_file = File.open("tt/trend/current_trends.json")

  trends = JSON.parse(trend_file.gets)
  
  per_hour = PerHour.last
  a = PerFiveMin.create(:per_hour_id => per_hour.id)
  position = 1

  trends[0]["trends"].each do |x|
    ttt = TtTerm.find(:first, :conditions => ["term = ?", x["name"].upcase.gsub(/[^0-9A-Za-z]/, '')])
    puts x["name"]
    if ttt == nil
      tttnew = TtTerm.create(:term => x["name"].upcase.gsub(/[^0-9A-Za-z]/, ''))
      Tt.create(:position => position, :tt_term_id => tttnew.id, :per_five_min_id => a.id )
      TtScore.create(:score => (11 - position), :minutes => 5, :tt_term_id => tttnew.id)
    else
      Tt.create(:position => position, :tt_term_id => ttt.id, :per_five_min_id => a.id )
      tt_score = TtScore.find(ttt.id)
      if tt_score == nil
        TtScore.create(:score => (11 - position), :minutes => 5, :tt_term_id => ttt.id)
      else
        tt_score.score = tt_score.score + (11 - position)
        tt_score.minutes = tt_score.minutes + 5
        tt_score.save
      end

    end
    position = position + 1
  end
end
