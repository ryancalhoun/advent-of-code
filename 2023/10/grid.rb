require_relative 'spot'

class Grid

  attr_accessor :starting, :path, :right_turns, :left_turns, :enclosed
  def initialize
    @g = []
    @starting = nil

    @path = []
    @right_turns = 0
    @left_turns = 0

    @enclosed = []
  end

  def at(i, j)
    (@g[i] ||= [])[j] ||= Spot.new(i, j) {|s| @starting = s}
  end

  def get(i, j)
    if i >= 0 && j >= 0
      (@g[i] || [])[j]
    end
  end

  def path_length
    @path.size
  end

  def find_loop!
    at = starting

    loop do
      at.visit!
      @path << at
      count_turn!

      connected = find_neighbors(at).select {|n| at.connected?(n) && !n.visited}
      if connected.empty?
        break
      end
      at = connected.first
    end
  end

  def count_turn!
    if @path.size >= 3
      di1 = @path[-1].i - @path[-2].i
      dj1 = @path[-1].j - @path[-2].j

      di0 = @path[-2].i - @path[-3].i
      dj0 = @path[-2].j - @path[-3].j

      case [di0,dj0,di1,dj1]
      when [1,0,0,-1], [0,-1,-1,0], [-1,0,0,1], [0,1,1,0]
        @right_turns += 1
      when [1,0,0,1], [0,-1,1,0], [-1,0,0,-1], [0,1,-1,0]
        @left_turns += 1
      end
    end
  end

  def find_enclosed!
    @enclosed = []

    (@path.size-1).times do |p|
      this = @path[p+1]
      prev = @path[p]

      di = (this.i - prev.i) * winding
      dj = (this.j - prev.j) * winding

      found = all_enclosed(get(this.i + dj, this.j - di)) + [enclose_it(get(prev.i + dj, prev.j - di))]

      @enclosed += found.compact
    end
  end

  def winding
    @right_turns > @left_turns ? 1 : -1
  end

  def enclose_it(spot)
    if spot && !spot.visited && !spot.enclosed
      spot.enclose!
      spot
    end
  end

  def all_enclosed(spot)
    found = []

    if enclose_it(spot)
      found << spot
      find_neighbors(spot).each do |n|
        found += all_enclosed(n)
      end
    end
    found
  end

  def find_neighbors(spot)
    [get(spot.i, spot.j-1), get(spot.i, spot.j+1), get(spot.i-1, spot.j), get(spot.i+1, spot.j)].compact
  end
end
