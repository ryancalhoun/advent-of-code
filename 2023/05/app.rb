require_relative 'target'

class App
  attr_reader :start, :finish

  def initialize(part:)
    @part = part
    @input = []
    @maps = {}
  end

  def run(filename)
    load_maps!(filename)
    find_min_finish
  end

  def sources
    @maps.keys
  end

  def find_min_finish
    locs = []

    if @part == 1
      @input.each do |x|
        locs << get_value(x)
      end
    else
      @input.each_slice(2) do |x,len|
        locs << get_ranges(x..x + len-1).first.first
      end
    end

    locs.sort.first
  end

  def get_value(x)
    type = @start

    m = @maps[@start]

    loop do
      x = m[x]

      break if m.type == @finish
      m = @maps[m.type]
    end

    x
  end

  def get_ranges(range)
    _get_ranges_of(@start, [range])
  end

  def _get_ranges_of(type, ranges)
    if @finish == type
      return ranges
    end

    m = @maps[type]

    results = []

    ranges.each do |range|
      mapped = m[range]
      results.concat _get_ranges_of(m.type, mapped)
    end

    return results.sort_by(&:first)
  end

  def load_maps!(filename)
    File.open(filename) do |f|
      current = nil
      f.each_line do |line|
        case line.chomp
        when /^(\w+)s:/
          @start = $1
          @input.concat line.scan(/\d+/).map(&:to_i)

        when /\smap:/
          source, dest = /(\w+)-to-(\w+)/.match(line).captures
          current = @maps[source] = Target.new dest

          @finish = dest unless @maps[dest]

        when ''
          current = nil

        else
          dest, source, len = line.scan(/\d+/).map(&:to_i)
          current.add_range(dest, source, len)

        end
      end
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
