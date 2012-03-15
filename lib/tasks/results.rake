require 'rubygems'
require 'fastercsv'
#require 'config/environment'

#task :create_per_five_min => :environment do
task :results do
  term_ids = Array.new
  per_min_count = PerMin.all.count
  puts per_min_count.to_s + " mins"


=begin
  Term.all.each  do |t|
    if t.frequent_per_min_terms.count > (per_min_count * 0.90)
      term_ids << t.id
      puts t.id.to_s + " " + t.term.to_s + ": " + t.frequent_per_min_terms.count.to_s
    end
  end
=end

  #terms = ["LOVE", "YOU", "THE", "PHOTO", "LOL"]
  terms = ["HAPPYINTERNATIONALWOMENSDAY ", "INVISIBLECHILDREN", "JORDANFARMAR", "MYFAVORITETEXT", "JENNIFERSBODY"]

  terms.each do |term|
    term_ids << Term.find(:first, :conditions => "term = '#{term}'").id
    puts Term.find(term_ids.last).term
  end

  #term_ids = [1, 2, 3]

  term_ids.each do |t|

    FasterCSV.open("/home/neilmarion/Dropbox/twitter_project/results/ttanalyzer_development_20120115_1354/#{Term.find(t).term.gsub!(" ", "")}_results.csv", "w") do |csv|
      
      count = 1
      z_ave = 0
      a = Array.new
      b = Array.new

      #term_ids.each do |t|
        Term.find(t).zscores.each do |z|
          if count % 30 == 0
            d = 6
            #a << ((z_ave/30) * 10**d).round.to_f / 10**d
            a << z_ave / 30
            z_ave = 0
            count = 0
          else
            d = 8
            z_ave = z.zscore.to_f + z_ave.to_f
            #z_ave = ((z.zscore.to_f * 10**d).round.to_f / 10**d) + z_ave.to_f
          end

          count = count + 1

        end

        count = 1
        freq = 0

        Term.find(t).frequent_per_min_terms.each do |f|
          if count % 30 == 0
            #a << ((z_ave/30) * 10**d).round.to_f / 10**d
            b << freq / 30
            freq = 0    
            count = 0
          else
            freq = freq + f.frequency
            #z_ave = ((z.zscore.to_f * 10**d).round.to_f / 10**d) + z_ave.to_f
          end
          count = count + 1

        end

        csv << "#{Term.find(t).term}"
        csv << ""
        csv << "ZSCORE OVER TIME"
        csv << a
        csv << "AVE FREQUENCY PER 30 MINUTES"
        csv << b
        a = Array.new
        b = Array.new
      #end

    end

  end

end
