require 'rubygems'
require 'config/environment'

task :lossy_count_tweets do

  t = Hash.new # tuples container
  n = 0
  s, e, w, c = 0 # support, error, buckets/width, current bucket
  cb = 1



  #file = File.open("tt/term/tryterms.txt")
  file = File.open("tt/term/#{Time.now().min-2}terms.txt")
  file_n = File.open("tt/n/#{Time.now().min-2}n.txt")
  total_tweets = file_n.gets
  total_terms = file_n.gets
  file_n.close

  puts "Enter support"
  s = 3/total_terms.to_i
  puts "Enter error"
  e = s*0.1
  w = 1/e.to_f


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

  file_f = File.open("tt/frequent/#{Time.now().min-2}frequent.txt", 'w')

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
