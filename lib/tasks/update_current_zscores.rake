require 'rubygems'
require 'config/environment'

task :update_current_zscores do
  last_min = PerMin.last.id
  
  ZscoreHistorical.all.each do |zh|
    if last_min - zh.last_min > 1

      plus_n = last_min - zh.last_min - 1

      begin
        zscore = (0 - zh.ave(plus_n.to_f) ) / zh.std(plus_n.to_f)
        #zscore = (0 - (zh.sum.to_f / zh.n.to_f))/(Math.sqrt(  (zh.sqr_total.to_f / zh.n.to_f + plus_n) - (zh.sum.to_f/zh.n.to_f)**2  )  )
        zc = ZscoreCurrent.find(:first, :conditions => ["term_id = ?", zh.term_id])
        zc.zscore = zscore
        zc.save
      rescue Exception => e
        puts "@update_current_zscores: " + e.to_s
      end
    end
  end

  
end
