require 'prime'

def sum_of_factors(*p)
  x = Prime.first(p.size)

  sum = 1
  p.each_with_index do |a,i|
    if a > 0
      sum *= (x[i]**(a+1)-1)/(x[i]-1)
    end
  end
  sum
end

def prime(*p)
  x = Prime.first(p.size)
  num = 1
  p.each_with_index do |a,i|
    num *= x[i]**a
  end
  num
end

def gen(p, t, m, i, &block)
  if i == p.size
    block.call p
    return
  end

  (0..(i == 0?m:p[i-1])).each do |x|
    p[i] = x
    gen(p, t, m, i+1, &block)
  end
  nil
end

def factors(n)
  m = n.prime_division
  p = [1]
  m.each do |v|
    p = p.product((0..v[1]).map {|e| v[0]**e})
  end
  p.map {|v| v.flatten.inject(:*)}.select {|y| y*50 > n}
end

t = File.read('full.txt').to_i
ones = []
while 10*sum_of_factors(*ones) < t
  ones << 1
end

first = nil
gen([0] * ones.size, t, ones.size, 0) do |p|
  next unless 10*sum_of_factors(*p) > t
  v = prime(*p)
  first = [first, v].compact.min
end
puts first

f = t/11/4
while 11*factors(f).sum < t
  f += 1
end
puts f


