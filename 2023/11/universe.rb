class Galaxy
  attr_accessor :i, :j
  def initialize(i, j)
    @i, @j = i, j
  end
end
class Universe
  def initialize(rate: 2)
    @galaxies = []
    @rate = rate
  end
  def add_galaxy(g)
    @galaxies << g
  end
  def expand!
    expand_by! :i
    expand_by! :j
  end
  def expand_by!(dim)
    last = 0
    to_add = 0
    @galaxies.sort_by(&dim).each do |g|
      val = g.send(dim)
      diff = val - last
      last = val

      to_add += diff - 1 if diff > 1
      g.send("#{dim}=", to_add*(@rate-1) + val)
    end
  end
  def find_shortest_paths
    paths = []
    each_pair do |a,b|
      paths << (a.i - b.i).abs + (a.j - b.j).abs
    end

    paths
  end
  def each_pair
    @galaxies.each_with_index do |g,n|
      (@galaxies.size - n - 1).times do |m|
        yield g, @galaxies[n+m+1]
      end
    end
  end
  def to_s
    str = ''
    max_size do |height,width|
      height.times do |i|
        width.times do |j|
          if @galaxies.find {|g| g.i == i && g.j == j}
            str += '#'
          else
            str +=  '.'
          end
        end
        str += "\n"
      end
    end
    str
  end
  def max_size
    h = @galaxies.map(&:i).max + 1
    w = @galaxies.map(&:j).max + 1
    yield h, w
  end
end
