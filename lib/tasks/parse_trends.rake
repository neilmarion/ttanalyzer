require 'rubygems'
require 'config/environment'

task :parse_trends do
  trend_file = File.open("tt/trend/current_trends.json")

  trends = JSON.parse(trend_file.gets)
  
  a = PerFiveMin.create
  position = 1

  trends[0]["trends"].each do |x|
    ttt = TtTerm.find(:first, :conditions => ["term = ?", x["name"].upcase])
    puts x["name"]
    if ttt == nil
      tttnew = TtTerm.create(:term => x["name"].upcase)
      Tt.create(:position => position, :tt_term_id => tttnew.id, :per_5_min_id => a.id )
    else
      Tt.create(:position => position, :tt_term_id => ttt.id, :per_5_min_id => a.id )
    end
    position = position + 1
  end
end
