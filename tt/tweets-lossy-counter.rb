require 'rubygems'  

t = Hash.new # tuples container
n = 0
s, e, w, c = 0 # support, error, buckets/width, current bucket
cb = 1

puts "Enter support"
s = gets
puts "Enter error"
e = gets
w = 1/e.to_f

file = File.open("term/7terms.txt")


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

file_f = File.open("frequent/#{Time.now().min}frequent.txt", 'w')

puts "RESULTS\n=======\n e   f \n"
t.keys.each do |x|
  file_f.puts "#{t[x]["t"]}   #{t[x]["f"]}"
end

file_f.close
