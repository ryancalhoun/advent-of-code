class MappingRange
  def initialize(dest, source, len)
    @dest = dest
    @source = source
    @len = len
  end
  def lookup(source)
    if source.is_a?(Range)
      lookup_range source
    else
      if (first..last).include?(source)
        return @dest + source-first
      end
    end
  end
  def lookup_range(source)
    r0 = [first, source.first].max
    r1 = [last, source.last].min

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
  def first
    @source
  end
  def last
    @source + @len - 1
  end
end

