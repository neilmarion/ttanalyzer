
puts "Enter values (enter '-1' to quit entering values): "

a = Array.new

begin
  n = gets
  break if n.to_i < 0
  a << n.to_i
end while true

puts "Enter current trend"

o = gets

# computing total
sum = 0

a.each do |aa|
  sum = sum + aa
end

# computing ave
ave = sum.to_f / a.length.to_f

#computing standard deviation

variance = 0
a.each do |aa|
  variance = variance + (aa - ave)**2
end

std = Math.sqrt(variance.to_f/a.length.to_f)

zscore = (o.to_f-ave)/std.to_f

puts "length: " + a.length.to_s
puts "sum: " + sum.to_s
puts "ave: " + ave.to_s
puts "variance: " + variance.to_s

puts "zscore: " + zscore.to_s
puts "zscore / duration: " + (zscore/a.length).to_f.to_s
