connections = {}

STDIN.each_line do |line|
  cmp, others = line.strip.split ':'

  others.split(' ').each do |connected|
    (connections[cmp] ||= []) << connected
    (connections[connected] ||= []) << cmp
  end 
end

def contract(g, u, v)
  e = ((g[u] + g[v]) - [u, v]).uniq
  g.delete u
  g.delete v
  contracted = [u, v].join('-')
  g[contracted] = e

  g.each do |k,e|
    if i = e.index(u)
      e[i] = contracted
    end
    if i = e.index(v)
      e[i] = contracted
    end
    e.uniq!
  end
end

def find_min_path(connections, from, to)
  weight = { from => 0 }

  q = [from]
  until q.empty?
    p = q.shift
    return weight[p] if p == to


    connections[p].each do |n|
      if !weight[n] || weight[n] > weight[p] + 1
        weight[n] = weight[p] + 1

        q << n
        q.sort_by! {|v| weight[v] }
        q.uniq!
      end
    end
  end
end

def deep_copy(g)
  copy = {}
  g.each do |k,v|
    copy[k] = v.dup
  end
  copy
end

def cut_graph(g)
  g = deep_copy g

  while g.keys.count > 2
    u = g.keys.sample
    v = g[u].sample

    contract g, u, v
  end

  g.keys.map {|k| k.split('-') }
end

def count_cuts(g, a, b)
  cuts = a.map { |cmp|
    (g[cmp] & b)
  }.flatten

  cuts.size
end

loop do
  a, b = cut_graph(connections)

  if count_cuts(connections, a, b) == 3
    puts a.inspect
    puts b.inspect
    puts a.size * b.size
    break
  end
end

