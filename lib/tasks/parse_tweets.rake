
task :parse_tweets do
  #text_file = File.open("tt/term/#{Time.now().min}terms.txt", 'w')
  text_file = File.open("tt/term/tryterms.txt", 'w')
  n_file = File.open("tt/n/#{Time.now().min}n.txt", 'w')

  #file = File.open(Time.now().min.to_s+"stream.txt")
  n = 0
  o = 0
  file = File.open("tt/json/55stream.json")
    #likes = JSON.parse(f.read)
    while line = file.gets
      #puts "#{line}"
      tweet = JSON.parse(line)
      if tweet["text"]
        tweet["text"].split(" ").each do |s|
          #puts s
          u = s.gsub(/[^0-9A-Za-z]/, '')
          if u.length > 2
            text_file.print u + " "
            o = o + 1
          end
        end
      text_file.print "\n"
      end

      n = n + 1
      #puts tweet["text"]
    end
  puts n.to_s + " total lines"
  puts o.to_s + " total terms"
  n_file.print "#{n}\n"
  n_file.print "#{o}\n"
  

  file.close
  text_file.close
  n_file.close
end
