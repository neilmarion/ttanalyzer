require 'rubygems'
#require 'config/environment'

task :empty_zscore_sum_per_five_min do
  ZscoreSumPerFiveMin.all.each do |zspfm|
    zspfm.zscore_sum = nil
    zspfm.save
  end
end
