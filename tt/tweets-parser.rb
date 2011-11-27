require 'rubygems'  
require 'json'

#
# Parses json files and breaks down every tweets into per term basis (' ' delimeter)
#

#puts Time.now().min

text_file = File.open("term/#{Time.now().min}terms.txt", 'w')
n_file = File.open("n/#{Time.now().min}n.txt", 'w')

#file = File.open(Time.now().min.to_s+"stream.txt")
n = 0
file = File.open("json/55stream.json")
  #likes = JSON.parse(f.read)
  while line = file.gets
    #puts "#{line}"
    tweet = JSON.parse(line)
    if tweet["text"]
      tweet["text"].split(" ").each do |s|
        #puts s
        text_file.print s.gsub(/[^0-9A-Za-z]/, '') + " "
      end
    text_file.print "\n"
    end

    n = n + 1
    #puts tweet["text"]
  end
puts n.to_s + " total lines"
n_file.print "#{n}"

file.close
text_file.close
n_file.close

#puts "Hello World"
