class Sequence
  def initialize(values)
    @values = values
  end

  def next_value
    extrapolate_value @values do |original, extrapolated|
      original.last + extrapolated
    end
  end

  def prev_value
    extrapolate_value @values do |original, extrapolated|
      original.first - extrapolated
    end
  end

  def extrapolate_value(values, &block)
    if values.all?(0)
      return 0
    end

    diffs = []
    (values.size - 1).times do |i|
      diffs << (values[i+1] - values[i])
    end

    return block.call values, extrapolate_value(diffs, &block)
  end
end
