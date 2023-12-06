require_relative 'mapping_range'

class Target
  attr_reader :type
  def initialize(type)
    @type = type
    @ranges = []
  end
  def [](source)
    if source.is_a?(Integer)
      @ranges.map {|r| r.lookup source }.compact.first || source
    else
      get_ranges source
    end
  end
  def get_ranges(range)
    mapped = []
    covered = []
    uncovered = []

    @ranges.each do |r|
      x = r.covered(range)

      if x
        mapped << r.lookup(x)
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
    if prev <= range.last
      uncovered << (prev..range.last)
    end

    mapped.concat uncovered
  end
  def add_range(dest, source, len)
    @ranges << MappingRange.new(dest, source, len)
  end
end
