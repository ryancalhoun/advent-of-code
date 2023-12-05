seeds = []
$maps = {}
current = nil

class MappingRange
  def initialize(dest, source, len)
    @dest = dest
    @source = source
    @len = len
  end
  def lookup(source)
    if (first..last).include?(source)
      return @dest + source-first
    end
  end
  def lookup_range(range)
    r0 = [first, range.first].max
    r1 = [last, range.last].min

    if r0 <= r1
      start = @dest + r0 - first
      len = r1 - r0
      start .. start+len
    end
  end
  def covered(range)
    r0 = [first, range.first].max
    r1 = [last, range.last].min
    if r0 <= r1
      r0..r1
    end
  end
  def before(range)
    if range.first < first && range.last >= first
      range.first..first-1
    end
  end
  def after(range)
    if range.first <= last && range.last > last
      last+1..range.last
    end
  end
  def first
    @source
  end
  def last
    @source + @len - 1
  end
end

class Target
  attr_reader :type
  def initialize(type)
    @type = type
    @ranges = []
  end
  def [](i)
    @ranges.map {|r| r.lookup i}.compact.first
  end
  def get_ranges(range)
    mapped = []
    covered = []
    uncovered = []

    @ranges.each do |r|
      x = r.covered(range)

      if x
        mapped << r.lookup_range(x)
        covered << x
      end
    end

    prev = range.first
    covered.sort_by(&:first).each do |c|
      if prev < c.first
        uncovered << (prev..c.first-1)
      end
      prev = c.last+1
    end
    if prev < range.last
      uncovered << (prev..range.last)
    end

    in_size = range.size
    out_size = (covered.map(&:size).inject(:+) || 0) + (uncovered.map(&:size).inject(:+) || 0)
    if in_size != out_size
      raise "#{range} -> #{covered}, #{uncovered}"
    end

    mapped.concat uncovered

    mapped
  end
  def add_range(dest, source, len)
    @ranges << MappingRange.new(dest, source, len)
  end
end

def get_ranges(dest, source, ranges)
  #puts "Get #{dest}, #{source}, #{ranges}"
  if dest == source
    return ranges
  end

  m = $maps[source]

  results = []

  ranges.each do |range|
    mapped = m.get_ranges range
    #puts "#{source}->#{dest}: #{range}->#{mapped}"
    results.concat get_ranges(dest, m.type, mapped)
  end

  return results.sort_by(&:first)
end

STDIN.each_line do |line|
  case line.chomp
  when /seeds:/
    seeds.concat line.scan(/\d+/).map(&:to_i)
  when /map:/
    source, dest = /(\w+)-to-(\w+)/.match(line).captures
    current = $maps[source] = Target.new dest
  when ''
    current = nil
  else
    dest, source, len = line.scan(/\d+/).map(&:to_i)

    current.add_range(dest, source, len)
  end
end

locs = []
seeds.each_slice(2) do |start,len|
  locs << get_ranges('location', 'seed', [start..start+len-1]).first.first
end

puts locs.sort.first
