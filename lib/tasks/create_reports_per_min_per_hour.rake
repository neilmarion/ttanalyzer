require 'rubygems'
require 'fastercsv'
require 'config/environment'

task :create_reports_per_min_per_hour do
  per_hour = PerHour.find(4)
  per_mins = per_hour.per_min

  FasterCSV.open("data2.csv", "w") do |csv|
    # create terms header
    #ZscoreAvePerHour.find_zscore_ave_per_hour(per_hour.id)
    zsaph = ZscoreAvePerHour.find_zscore_ave_per_hour(4)

    a = Array.new

    zsaph.each do |z|
      a << Term.find(z.term_id).term
    end
    csv << a

    puts per_mins.count

    per_mins.each do |pm|
    a = Array.new
      zsaph.each do |z|
        #puts pm.id.to_s + "," + z.term_id.to_s
        begin
          a << Zscore.find_zscore_per_min_per_term(pm.id, z.term_id).first.zscore
        rescue
          a << 0
        end
      end
    csv << a
    end    

  end
  
end

