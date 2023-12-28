grid = []

STDIN.each_line do |line|
  grid << line.strip.each_char.with_index.map do |char,j|
    if char == 'S'
      0
    elsif char == '.'
      -1 
    end
  end
end

start = nil
grid.each_with_index do |row, i|
  row.each_with_index do |val, j|
    start = [i, j] if val == 0
  end
end

def reset(grid)
  grid.each_with_index do |row, i|
    row.size.times do |j|
      row[j] = -1 if row[j].is_a? Integer
    end
  end
end

def neighbors(p, height, width)
  yield [p.first-1, p.last] if p.first > 0
  yield [p.first+1, p.last] if p.first < height-1
  yield [p.first, p.last-1] if p.last > 0
  yield [p.first, p.last+1] if p.last < width-1
end

def fill(grid, start)
  grid[start.first][start.last] = 0

  q = [start]
  until q.empty?
    p = q.shift

    plot = grid[p.first][p.last]
    neighbors(p, grid.size, grid.last.size) do |n|
      neighbor = grid[n.first][n.last]
      next unless neighbor

      if neighbor < 0
        grid[n.first][n.last] = plot + 1
        q << n
      end
    end
  end
end

def count(grid)
  total = 0
  grid.each do |row|
    row.each do |v|
      if v && yield(v)
        total += 1
      end
    end
  end
  total
end

reset grid
fill(grid, start) 
puts count(grid) { |v|
  (0..64).include?(v) && v % 2 == 0
}
exit


## Part 2

reset grid
fill(grid, start) 
even = count(grid) { |v|
  v % 2 == 0
}
odd = count(grid) { |v|
  v % 2 == 1
}
puts "Even = #{even}, odd = #{odd}"


reset grid
fill(grid, [0, 65])
from_top = count(grid) { |v|
  (0..130).include?(v) && v % 2 == 0
}
puts "From top = #{from_top}"

reset grid
fill(grid, [130, 65])
from_bottom = count(grid) { |v|
  (0..130).include?(v) && v % 2 == 0
}
puts "From bottom = #{from_bottom}"

reset grid
fill(grid, [65, 0])
from_left = count(grid) { |v|
  (0..130).include?(v) && v % 2 == 0
}
puts "From left = #{from_left}"

reset grid
fill(grid, [65, 130])
from_right = count(grid) { |v|
  (0..130).include?(v) && v % 2 == 0
}
puts "From right = #{from_right}"

reset grid
fill(grid, [0, 0])
top_left = count(grid) { |v|
  (0..195).include?(v) && v % 2 == 1
}
top_left2 = count(grid) { |v|
  (0..64).include?(v) && v % 2 == 0
}
puts "From top left = #{top_left}, #{top_left2}"

reset grid
fill(grid, [0, 130])
top_right = count(grid) { |v|
  (0..195).include?(v) && v % 2 == 1
}
top_right2 = count(grid) { |v|
  (0..64).include?(v) && v % 2 == 0
}
puts "From top right = #{top_right}, #{top_right2}"

reset grid
fill(grid, [130, 130])
bottom_right = count(grid) { |v|
  (0..195).include?(v) && v % 2 == 1
}
bottom_right2 = count(grid) { |v|
  (0..64).include?(v) && v % 2 == 0
}
puts "From bottom right = #{bottom_right}, #{bottom_right2}"

reset grid
fill(grid, [130, 0])
bottom_left = count(grid) { |v|
  (0..195).include?(v) && v % 2 == 1
}
bottom_left2 = count(grid) { |v|
  (0..64).include?(v) && v % 2 == 0
}
puts "From bottom left = #{bottom_left}, #{bottom_left2}"


steps = 26501365
grids = (steps - start.first - 1) / grid.size
puts grids

odd_even = [1, 0]
(grids).times do |i|
  odd_even[i%2] += i * 4
end
edges = grids

puts ( odd_even[0] * odd + odd_even[1] * even + edges * (top_right + top_left + bottom_right + bottom_left) + (edges+1) + (top_right2 + top_left2 + bottom_right2 + bottom_left2) + from_top + from_left + from_right + from_bottom)




