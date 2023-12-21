class Damaged
  attr_reader :size, :candidates
  def initialize(size)
    @size = size
    @candidates = []
    @i = 0
    @locked = false
  end
  def identify_candidates!(records)
    @candidates = []

    (records.size - (size-1)).times do |i|
      next if i > 0 && records[i-1] == false
      next if i + size < records.size && records[i+size] == false
      next if records.slice(i..i+size-1).include?(true)

      candidates << i
    end
  end
  def not_before!(pos)
    candidates.delete_if {|c| c < pos + 1 }
  end
  def not_after!(pos)
    candidates.delete_if {|c| c + size + 1 > pos }
  end
  def first_end_pos
    candidates.first + size
  end
  def last_start_pos
    candidates.last
  end
  def from(off=0)
    candidates[@i+off]
  end
  def to(off=0)
    from(off)+size-1
  end
  def to_range(off=0)
    from(off)..to(off)
  end
  def includes?(range)
    candidates.find {|c| c <= range.first && c+size > range.last }
  end
  def locked?
    @locked
  end
  def done?
    locked? || @i == candidates.size - 1
  end
  def step!
    !done? && @i += 1
  end
  def lock!
    @locked = true
  end
  def reset_after!(pos)
    not_before! pos
    @i = 0
  end
end
