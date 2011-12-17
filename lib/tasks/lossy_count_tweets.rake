require 'rubygems'
#require 'config/environment'

task :lossy_count_tweets do

  t = Hash.new # tuples container
  
  n = 0
  s, e, w, c = 0 # support, error, buckets/width, current bucket
  cb = 1

  file_log = File.open("tt/log/log.log", "a")
  min_now = (Time.now().min-2)%60


=begin
  file = File.open("tt/term/tryterms.txt")
  file_n = File.open("tt/n/tryn.txt")
=end



#=begin
  file = File.open("tt/term/#{(Time.now().min-2)%60}terms.txt")
  file_n = File.open("tt/n/#{(Time.now().min-2)%60}n.txt")
#=end
  total_tweets = file_n.gets
  total_terms = file_n.gets
  total_permutations = file_n.gets
  file_n.close

  puts "Enter support"
  s = 3/total_permutations.to_i
  puts "Enter error"
  e = s*0.1
  w = 1/e.to_f


  file_log.puts "Begin LOSSY COUNTING for #{min_now}terms.txt at #{Time.now}"
  while line = file.gets
    n = n + 1

    v = Array.new
    u = Array.new

    line.split(" ").each do |x|
      v << x
    end

    for m in 0...v.length
      for o in m...v.length
        str = ""

        v[o-m...o+1].each do |z|
          str = str + z + " " 
        end

        u << str
      end
    end

    #insert tuple to T
    temp = Hash.new # hash for storing tuples. This will be checked everytime to determine if substring was already inserted to t to avoid duplication for a single tweet
    u.each do |s|  
      if temp[s.upcase].nil?
        if t[s.upcase].nil?
          a = Hash["t", s,"f", 1, "d", cb - 1]
          t[s.upcase] = a
          temp[s.upcase] = "1"
        else
          t[s.upcase]["f"] = t[s.upcase]["f"] + 1
          t[s.upcase]["d"] = t[s.upcase]["d"] + 1
        end
      end
    end
    #end of inserting tuple to T

=begin
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
=end

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


  file_f = File.open("tt/frequent/#{(Time.now().min-2)%60}frequent.txt", 'w')

  #puts "RESULTS\n=======\n e   f \n"
  #create per_min
  a = PerMin.create
  PerMinStreamTweetTotal.create(:total => total_tweets.to_i, :per_min_id => a.id)
  PerMinStreamTermTotal.create(:total => total_terms.to_i, :per_min_id => a.id)

  #term = Term.find(:first, :conditions => ["term = ?", t[x]["t"].upcase ])

  new_terms = 0

  t.keys.each do |x|
    term = Term.find(:first, :conditions => ["term = ?", t[x]["t"].upcase ])
    if term == nil # term not yet in record
      ti = Term.create(:term => t[x]["t"].upcase)
      FrequentPerMinTerm.create(:frequency => t[x]["f"].to_i, :term_id => ti.id, :per_min_id => a.id )
      #create its historical zscore data, though no zscores recorded yet
      ZscoreHistorical.create(:n => 1, :sum => t[x]["f"].to_i, :sqr_total => (t[x]["f"].to_i)**2, :first_min => a.id, :last_min => a.id, :term_id => ti.id)
      ZscoreCurrent.create(:term_id => ti.id) # null zscore
      new_terms = new_terms + 1
    else # term already has began its life in the database :P
      FrequentPerMinTerm.create(:frequency => t[x]["f"].to_i, :term_id => term.id, :per_min_id => a.id )
      plus_n = a.id - term.zscore_historical.last_min - 1
      begin
        zscore = (t[x]["f"].to_f - term.zscore_historical.ave(plus_n))/term.zscore_historical.std(plus_n)
        Zscore.create(:zscore => zscore, :per_min_id => a.id, :term_id => term.id)
      rescue Exception=>e
        #error. Standard deviation might be out of domain
        puts e.to_s
      end
      #zscore = (t[x]["f"].to_f - (term.zscore_historical.sum.to_f / term.zscore_historical.n.to_f))/(Math.sqrt((term.zscore_historical.sqr_total.to_f / term.zscore_historical.n.to_f + plus_n)-(term.zscore_historical.sum.to_f/term.zscore_historical.n.to_f)**2  ))
      

      #update zscore current
=begin
      term.zscore_current.zscore = zscore
      term.zscore_current.save
=end
      
      #update zscore historical
      term.zscore_historical.n = term.zscore_historical.n + 1 + plus_n
      term.zscore_historical.sum = term.zscore_historical.sum + t[x]["f"].to_i
      term.zscore_historical.sqr_total = term.zscore_historical.sqr_total + (t[x]["f"].to_i)**2
      term.zscore_historical.last_min = a.id
      term.zscore_historical.save
    end

    file_f.puts "#{t[x]["t"]}   #{t[x]["f"]}"
  end

  PerMinNewTermTotal.create(:total => new_terms, :per_min_id => a.id)

  file_f.close

  file_log.puts "Succesful LOSSY COUNTING for #{min_now}terms.txt at #{Time.now}"
  file_log.close

end
