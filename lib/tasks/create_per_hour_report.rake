require 'rubygems'
require 'fastercsv'
require 'config/environment'

task :create_per_hour_report do
  #per_hour = PerHour.last
  per_hour = PerHour.all.reverse[1]
  #PerHour.create
  


  #ActiveRecord::Base.connection.select_values('SELECT DISTINCT term_id from zscore_trends_per_five_min_reports')
  #ActiveRecord::Base.connection.select_values('SELECT z.term_id FROM zscore_trends_per_five_min_reports z LEFT JOIN terms t ON t.id = z.term_id GROUP BY z.term_id ORDER BY SUM(z.zscore_ave)/60')

  #ActiveRecord::Base.connection.select_values('SELECT z.term_id FROM zscore_trends_per_five_min_reports z LEFT JOIN terms t ON t.id = z.term_id WHERE z.per_five_min_id = 5 GROUP BY z.term_id ORDER BY SUM(z.zscore_ave)/60 DESC')

  #ActiveRecord::Base.connection.select_values('SELECT p.id FROM per_mins p WHERE p.per_five_min_id = 4')

#SELECT tt.term FROM tts t LEFT JOIN tt_terms tt ON t.tt_term_id = tt.id WHERE per_five_min_id = 2

  

  FasterCSV.open("public/reports/#{per_hour.created_at.to_s.gsub(' ', '_')}.csv", "w") do |csv|
    # create terms header
    #ZscoreAvePerHour.find_zscore_ave_per_hour(per_hour.id)
    #zsaph = ZscoreAvePerHour.find_zscore_ave_per_hour(4)

    a = Array.new
    header = Array.new
    term_ids = ActiveRecord::Base.connection.select_values('SELECT z.term_id FROM zscore_trends_per_five_min_reports z LEFT JOIN terms t ON t.id = z.term_id GROUP BY z.term_id ORDER BY SUM(z.zscore_ave)/60 DESC')
    header << " "
    term_ids.each do |tids|
      header << Term.find(tids).term
    end

    csv << ["TTANALYZER", "HOURLY REPORT", per_hour.created_at]
    csv << " "
    csv << "ZSCORES"
    csv << header

    b = 1
    per_hour.per_five_min.each do |x|
      a = Array.new 
      a << x.created_at.to_s(:db) + "   " + b.to_s
      term_ids.each do |tids|
        #puts x.id.to_s + " " + tids.to_s
        begin
          a << ZscoreTrendsPerFiveMinReport.find_per_five_min_per_term(x.id, tids).first.zscore_ave/5
        rescue
          a << -0.01
        end
      end
      csv << a
      b = b + 1
    end

    csv << " "
    csv << "RANKS"
    csv << header

    b = 1
    per_hour.per_five_min.each do |x|
      a = Array.new
      a << x.created_at.to_s(:db) + "   " + b.to_s
      term_ids.each do |tids|
        #puts x.id.to_s + " " + tids.to_s
        begin
          rank = ZscoreTrendsPerFiveMinReport.find_per_five_min_per_term(x.id, tids).first.id
          rank = rank+10
          a << 11 - rank%(((rank-1)/10)*10)
        rescue
          a << ' '
        end
      end
      csv << a
      b = b + 1
    end

    csv << " "
    csv << "FREQUENCY"
    csv << header

    b = 1
    per_hour.per_five_min.each do |x|
      p = ActiveRecord::Base.connection.select_values("SELECT p.id FROM per_mins p WHERE p.per_five_min_id = '#{x.id}'")

      per_min_arr_string = "("      
      p.each do |pi|
        per_min_arr_string = per_min_arr_string + pi.to_s + ','
      end
      per_min_arr_string[per_min_arr_string.length-1] = ')'

      puts per_min_arr_string

      a = Array.new
      a << x.created_at.to_s(:db) + "   " + b.to_s
      
      term_ids.each do |tids|
        #puts x.id.to_s + " " + tids.to_s
        begin
          s = "SELECT SUM(f.frequency) FROM frequent_per_min_terms f LEFT JOIN terms t ON f.term_id = t.id WHERE f.per_min_id IN #{per_min_arr_string} AND f.term_id = '#{tids}' GROUP BY f.term_id"
          a << ActiveRecord::Base.connection.select_values(s).first
        rescue Exception => e
          #puts e.to_s
          a << 0
        end
      end
      csv << a
      b = b + 1
    end

    csv << " "
    csv << "RANKS BY TERM"
    csv << [" ", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    b = 1
    per_hour.per_five_min.each do |x|
      a = Array.new
      a << x.created_at.to_s(:db) + "   " + b.to_s
      s = "SELECT z.term_id FROM zscore_trends_per_five_min_reports z LEFT JOIN terms t ON t.id = z.term_id WHERE z.per_five_min_id = '#{x.id}' GROUP BY z.term_id ORDER BY SUM(z.zscore_ave)/60 DESC"
      ActiveRecord::Base.connection.select_values(s).each do |tids|
        begin
          a << Term.find(tids.to_i).term
        rescue
          a << 0
        end
      end
      csv << a
      b = b + 1
    end

    csv << " "
    csv << " "
    csv << " "
    csv << "RANKS BY TERM (TWITTER TRENDS)"
    csv << [" ", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    b = 1
    per_hour.per_five_min.each do |x|
      a = Array.new
      a << x.created_at.to_s(:db) + "   " + b.to_s
      s = "SELECT tt.term FROM tts t LEFT JOIN tt_terms tt ON t.tt_term_id = tt.id WHERE per_five_min_id = '#{x.id}'"
      ActiveRecord::Base.connection.select_values(s).each do |tids|
        begin
          a << tids
        rescue
          a << 0
        end
      end
      csv << a
      b = b + 1
    end


    csv << " "
    csv << "SCORES (TWITTER TRENDS)"
    csv << [" ", "TERM", "SCORE", "MINUTES"]
    b = 1
    TtScore.order_by_score_minutes.each do |tids|
      a = Array.new
      a << b
      a << TtTerm.find(tids.tt_term_id).term
      a << tids.score
      a << tids.minutes
      #a << [b, TtTerm.find(tids.tt_term_id), tids.score, tids.minutes]
      csv << a
      b = b + 1
    end

  end

  ZscoreTrendsPerFiveMinReport.destroy_all
  
end

