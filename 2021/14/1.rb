pc = {}
STDIN.readline.chomp.each_char.each_cons(2) do |a,b|
  p = "#{a}#{b}"
  pc[p] ||= 0
  pc[p] += 1
end

STDIN.readline

rules = {}
STDIN.each_line do |ins|
  m = /(\w\w) -> (\w)/.match(ins)
  rules[m[1]] = m[2]
end

ARGV[0].to_i.times do
  p2 = {}
  pc.each do |p,c|
    ins = rules[p]
    a = "#{p[0]}#{ins}"
    b = "#{ins}#{p[1]}"
    p2[a] ||= 0
    p2[a] += c
    p2[b] ||= 0
    p2[b] += c
  end
  pc.replace p2
end

puts pc

c = {}
pc.each do |k,v|
  l = k[1]
  c[l] ||=0
  c[l] += v
end

puts c
