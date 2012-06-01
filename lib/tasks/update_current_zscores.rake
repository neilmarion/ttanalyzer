require 'rubygems'
require 'fastercsv'
require 'config/environment'

task :update_current_zscores do
  last_min = PerMin.last.id
  file_log = File.open("tt/log/udpate_current_zscores_log.log", "a")  
  file_log.puts "Began updating current zscores at " + Time.now().to_s



  ZscoreHistorical.all.each do |zh|
    

    if last_min - zh.last_min > 1

      plus_n = last_min - zh.last_min - 1
      
      begin
        #zscore = (0 - zh.ave(plus_n.to_f) ) / zh.std(plus_n.to_f)
        zscore = zh.zscore(0, plus_n.to_f, last_min - zh.first_min)
        #zscore = (0 - (zh.sum.to_f / zh.n.to_f))/(Math.sqrt(  (zh.sqr_total.to_f / zh.n.to_f + plus_n) - (zh.sum.to_f/zh.n.to_f)**2  )  )
        zc = ZscoreCurrent.find(:first, :conditions => ["term_id = ?", zh.term_id])
        zc.zscore = zscore
        zc.save
        zspfm = ZscoreSumPerFiveMin.find(:first, :conditions => ["term_id = ?", zh.term_id])
        zspfm.zscore_sum = zspfm.zscore_sum.to_f + zscore
        zspfm.save
      rescue Exception => e
        puts "@update_current_zscores: " + e.to_s
      end
    else
      begin
        z = Zscore.find(:last, :conditions => ["term_id = ?", zh.term_id])
        zc = ZscoreCurrent.find(:first, :conditions => ["term_id = ?", zh.term_id])
        zc.zscore = z.zscore
        zc.save
        #puts "positive zscore"
        zspfm = ZscoreSumPerFiveMin.find(:first, :conditions => ["term_id = ?", zh.term_id])
        zspfm.zscore_sum = zspfm.zscore_sum.to_f + z.zscore
        zspfm.save
      rescue

      end

    end
  end

  if Time.now().min % 5 == 0 # create a report
    l = PerFiveMin.last
    ZscoreSumPerFiveMin.top_ten_in_five_mins.each do |x|
      ZscoreTrendsPerFiveMinReport.create(:term_id => x.term_id, :per_five_min_id => l.id, :zscore_ave => (x.zscore_sum / 5))
    end
    file_log.puts "  Report created."

    ZscoreSumPerFiveMin.all.each do |zspfm|
      zspfm.zscore_sum = nil
      zspfm.save
    end

  end

  file_log.puts "  Ended updating current zscores at " + Time.now().to_s
  file_log.close

  

end
