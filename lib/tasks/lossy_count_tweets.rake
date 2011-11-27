require 'rubygems'
require 'config/environment'

task :lossy_count_tweets do

  t = Hash.new # tuples container
  n = 0
  s, e, w, c = 0 # support, error, buckets/width, current bucket
  cb = 1

  puts "Enter support"
  s = 0.000214
  puts "Enter error"
  e = 0.0000214
  w = 1/e.to_f

  file = File.open("tt/term/tryterms.txt")
  file_n = File.open("tt/n/38n.txt")
  total_terms = file_n.gets
  total_tweets = file_n.gets
  file_n.close


  while line = file.gets
    n = n + 1
    #insert tuple to T
    line.split(" ").each do |s|
      if t[s.upcase].nil?
        a = Hash["t", s,"f", 1, "d", cb - 1]
        t[s.upcase] = a
      else
        t[s.upcase]["f"] = t[s.upcase]["f"] + 1
        t[s.upcase]["d"] = t[s.upcase]["d"] + 1
      end
    end
    #end of inserting tuple to T

    if (n / w).ceil != cb
      cb = (n / w).ceil;
      
      #prune T
      t.keys.each do |x|
        if(t[x]["d"] <= cb)
          t.delete(x)
        end
      end
      #end of pruning T
    end

  end

  #prune T lastly
  t.keys.each do |x|
    if(t[x]["d"] <= cb)
      t.delete(x)
    end
  end
  #end of pruning T lastly

  file.close

  file_f = File.open("tt/frequent/#{Time.now().min}frequent.txt", 'w')

  #puts "RESULTS\n=======\n e   f \n"
  #create per_min
  a = PerMin.create
  PerMinStreamTweetTotal.create(:total => total_tweets.to_i, :per_min_id => a.id)
  PerMinStreamTermTotal.create(:total => total_terms.to_i, :per_min_id => a.id)

  #term = Term.find(:first, :conditions => ["term = ?", t[x]["t"].upcase ])

  t.keys.each do |x|
    term = Term.find(:first, :conditions => ["term = ?", t[x]["t"].upcase ])
    if term == nil
      ti = Term.create(:term => t[x]["t"].upcase)
      FrequentPerMinTerm.create(:frequency => t[x]["f"].to_i, :term_id => ti.id, :per_min_id => a.id )
    else
      FrequentPerMinTerm.create(:frequency => t[x]["f"].to_i, :term_id => term.id, :per_min_id => a.id )
    end

    file_f.puts "#{t[x]["t"]}   #{t[x]["f"]}"
  end

  file_f.close
end
