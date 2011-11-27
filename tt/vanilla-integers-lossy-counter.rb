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

file = File.open("temp/integer_stream.txt")

while line = file.gets
  n = n + 1
  #insert tuple to T
  if t[line.to_i].nil?
    a = Hash["f", 1, "d", cb - 1]
    t[line.to_i] = a
  else
    t[line.to_i]["f"] = t[line.to_i]["f"] + 1
    t[line.to_i]["d"] = t[line.to_i]["d"] + 1
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

puts "RESULTS\n=======\n e   f \n"
t.keys.each do |x|
  puts "#{x}   #{t[x]["f"]}"
end
