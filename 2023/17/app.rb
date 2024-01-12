require_relative 'vertex'

grid = []

STDIN.each_line do |line|
  grid << line.strip.each_char.map(&:to_i)
end

def neighbors(grid, p)
  n = []
  n << grid[p.first-1][p.last] if p.first > 0
  n << grid[p.first+1][p.last] if p.first < grid.size-1
  n << grid[p.first][p.last-1] if p.last > 0
  n << grid[p.first][p.last+1] if p.last < grid.last.size-1

  n
end

def find_path(grid, start, finish)
  nodes = []
  grid.each_with_index do |row, i|
    nodes << []
    row.each_with_index do |w, j|
      nodes[i][j] = Vertex.new(i, j, w)
    end
  end

  q = [nodes[start.first][start.last]]
  q.first.visit! 0, []

  until q.empty?
    u = q.shift

    neighbors(nodes, u.loc).each do |v|
      u.with_min do |cost, path|
        if v.visit! cost, path
          q << v
        end 
      end
    end
    q.sort_by! &:min_cost
    q.uniq!
    print "Current cost=#{u.min_cost} q=#{q.size}    \r"
  end
  puts
#  puts nodes.last.last.inspect
  puts nodes.last.last.min_cost

  n = nodes.last.last
  puts n.inspect

  path = []
  loop do
    best_path = n.min_path path
    puts best_path.inspect

    path << best_path

    start = best_path.first

    if start == [0, 0]
      break
    end
    n = nodes[start.first][start.last]
  end
  sum = grid.last.last
  path.reverse.each do |seg|
    puts "segment length=#{seg.size}"
    seg.each do |p|
      puts "(#{p.first},#{p.last}) = #{grid[p.first][p.last]}"
      next if p == [0, 0]
      sum += grid[p.first][p.last]
    end
  end
  puts sum

  grid.size.times do |i|
    grid[i].size.times do |j|
      if path.find{ |seg| seg.include?([i, j]) } or [grid.size-1, grid.last.size-1] == [i,j]
        print '#'
      else
        print '.'
      end
    end
    puts
  end

end

find_path(grid, [0, 0], [grid.size-1, grid.last.size-1])


