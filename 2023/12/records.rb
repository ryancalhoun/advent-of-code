class Records
  def initialize(records)
    @records = records
  end
  def size
    @records.size
  end
  def to_a
    @records
  end
  def to_s
    @records.map do |r|
      if r == true
        '.'
      elsif r == false
        '#'
      else
        '?'
      end
    end
  end
  def self.parse(str)
    state = {
      '.' => true,
      '#' => false,
    }
    new str.each_char.map{|c| state[c]}
  end

  def unknowns
    @records.select(&:nil?).size
  end
  def known_damaged
    @records.select {|r| r == false }.size
  end

  def cover_with(*ranges)
    covered = @records.map do |r|
      r != false
    end 

    ranges.flatten.each do |g|
      g.each do |i|
        covered[i] = false
      end
    end

    covered
  end

  def count_covered_with(*ranges)
    cover_with(*ranges).select {|r| r == false }.size
  end

  def covered_by(range)
    @records.slice(range).each_with_index.select {|r,i| r == false }.map {|r,i| i + range.first }
  end
end
