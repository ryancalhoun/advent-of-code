class Grid
  def self.load_from(f)
    new.tap do |g|
      f.each_line do |line|
        g << line.strip.each_char.map do |char|
          if char == 'S'
            0
          elsif char == '.'
            -1 
          end
        end
      end
    end
  end

  attr_reader :start

  def initialize
    @grid = []
  end

  def size
    @grid.size
  end

  def << row
    if s = row.index(0)
      @start = [@grid.size, s]
    end

    @grid << row
  end

  def reset! (start)
    @grid.each do |row|
      row.size.times do |j|
        row[j] = -1 if row[j].is_a? Integer
      end
    end

    @grid[start.first][start.last] = 0
  end

  def neighbors_of(p)
    yield [p.first-1, p.last] if p.first > 0
    yield [p.first+1, p.last] if p.first < @grid.size-1
    yield [p.first, p.last-1] if p.last > 0
    yield [p.first, p.last+1] if p.last < @grid[p.first].size-1
  end

  def fill!
    q = [@start]
    until q.empty?
      p = q.shift

      plot = @grid[p.first][p.last]
      neighbors_of(p) do |n|
        neighbor = @grid[n.first][n.last]
        next unless neighbor

        if neighbor < 0
          @grid[n.first][n.last] = plot + 1
          q << n
        end
      end
    end
  end

  def count
    total = 0
    @grid.each do |row|
      row.each do |v|
        if v && v >= 0 && yield(v)
          total += 1
        end
      end
    end
    total
  end
end
