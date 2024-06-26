require_relative 'grid'

g = Grid.load_from STDIN

g.fill!

if ENV['PART'].to_i == 1
  puts g.count { |v| (0..(ENV['STEPS'] || 64).to_i).include?(v) && v % 2 == 0 }
else
  steps = 26501365
  n = (steps - g.start.first) / g.size

  even = g.count { |v| v % 2 == 0 }
  odd = g.count { |v| v % 2 == 1 }

  corners = [[0, 65], [130, 65], [65, 0], [65, 130]].map do |start|
    g.reset! start
    g.fill!
    g.count { |v| (0..130).include?(v) && v % 2 == 0 }
  end.sum

  inside_edges, outside_edges = [[0, 0], [0, 130], [130, 130], [130, 0]].map do |start|
    g.reset! start
    g.fill!
    [ g.count { |v| (1..195).include?(v) && v % 2 == 1 },
      g.count { |v| (0..64).include?(v) && v % 2 == 0 } ]
  end.transpose.map(&:sum)

  repeated = [1, 0]
  (1..n-1).each do |i|
    repeated[i%2] += i * 4
  end

  puts (
    repeated[0] * odd + repeated[1] * even +
    (n-1) * inside_edges + (n) * outside_edges + corners
  )
end


