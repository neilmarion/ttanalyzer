require 'rubygems'
require 'config/environment'

task :create_per_five_min do
  per_hour = PerHour.last
  PerFiveMin.create(:per_hour_id => per_hour.id)
end
