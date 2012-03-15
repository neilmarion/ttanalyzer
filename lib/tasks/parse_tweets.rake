
task :parse_tweets do
  text_file = File.open("tt/term/#{(Time.now().min-1)%60}terms.txt", 'w')
  #text_file = File.open("tt/term/tryterms.txt", 'w')
  n_file = File.open("tt/n/#{(Time.now().min-1)%60}n.txt", 'w')
  file_log = File.open("tt/log/log.log", "a")

  #file = File.open(Time.now().min.to_s+"stream.txt")
  n = 0
  o = 0
  p = 0
  j = 0
  

  min_now = (Time.now().min-1)%60
  file_log.puts "Begin PARSING TWEETS for #{min_now}stream.json at #{Time.now}"
  #file = File.open("tt/json/trystream.json")
  file = File.open("tt/json/#{(Time.now().min-1)%60}stream.json")
    #likes = JSON.parse(f.read)
    while line = file.gets
      #puts "#{line}"
      tweet = JSON.parse(line)
      if tweet["text"]
        j = 0
        tweet["text"].split(" ").each do |s|
          #puts s
          u = s.gsub(/[^0-9A-Za-z]/, '')
          if u.length > 2
            text_file.print u + " "
            o = o + 1
            j = j + 1
          end
          p = p + ((j+1)*j)/2
        end
      text_file.print "\n"
      end

      n = n + 1
      #puts tweet["text"]
    end
    #11 - position
    #ZscoreHistorical.find(Term.find(:first, :conditions => "term = '#{name}'").id).sum
    PerFiveMin.last.tt.each do |tt|
      hjk = Term.find(:first, :conditions => "term = '#{tt.tt_term.term.gsub(/[^0-9A-Za-z]/, '')}'").nil? ? 11-tt.position : ( Term.find(:first, :conditions => "term = '#{tt.tt_term.term.gsub(/[^0-9A-Za-z]/, '')}'").frequent_per_min_terms.last.frequency + ((11-tt.position)*3) )
      #hjk = Term.find(:first, :conditions => "term = '#{tt.tt_term.term.gsub(/[^0-9A-Za-z]/, '')}'").nil? ? 11-tt.position : ZscoreHistorical.find(Term.find(:first, :conditions => "term = '#{tt.tt_term.term.gsub(/[^0-9A-Za-z]/, '')}'").id).sum + (11-tt.position)
      for i in 1..hjk
        text_file.print tt.tt_term.term.gsub(/[^0-9A-Za-z]/, '')
        text_file.print "\n"
        n = n + 1
      end      
    end
  puts n.to_s + " total lines"
  puts o.to_s + " total terms"
  puts p.to_s + " total substrings"
  n_file.print "#{n}\n"
  n_file.print "#{o}\n"
  n_file.print "#{p}\n"

  file_log.puts "  #{n} total tweets"
  file_log.puts "  #{o} total terms"
  file_log.puts "  #{p} total substrings"

  file.close
  text_file.close
  n_file.close

  file_log.puts "Succesful PARSING TWEETS for #{min_now}stream.json at #{Time.now}"
  file_log.close
end
