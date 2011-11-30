s = "Neil Marion Flores dela Cruz"

t = Array.new
u = Array.new

s.split(" ").each do |x|
  t << x
end

for n in 0...t.length
  for o in n...t.length
    u << t[o-n...o+1].to_s
  end
end

puts u
