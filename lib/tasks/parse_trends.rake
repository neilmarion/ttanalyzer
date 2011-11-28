
task :parse_trends do
  trend_file = File.open("tt/trends_temp/current_trends.json")

  trends = JSON.parse(trend_file.gets)
  
  trends[0]["trends"].each do |x|
    puts x["name"] if !x["promoted_content"] # this is the per trend. Antok na ako. Goodnight!
  end
end
