class Pattern
  def initialize
    @rows = []
    @cols = []
  end

  def score!(i, j)
    @rows[i] ||= 0
    @rows[i] += 2**j

    @cols[j] ||= 0
    @cols[j] += 2**i
  end

  def toggle!(i, j)
    @rows[i] = toggle_value @rows[i], j
    @cols[j] = toggle_value @cols[j], i
  end
  def toggle_value(n, i)
    m = n

    while m > 0
      d = Math.log2(m).to_i
      break unless d > i
      m -= 2**d
    end

    if m >= 2**i
      n - 2**i
    else
      n + 2**i
    end    
  end

  def row_reflection(skip: nil)
    reflection @rows, skip
  end
  def col_reflection(skip: nil)
    reflection @cols, skip
  end

  def row_similar(&block)
    each_similar @rows, &block
  end
  def col_similar(&block)
    each_similar @cols, &block
  end

  def find_pairs(list)
    h = {}
    list.each_with_index do |score, i|
      h[score] ||= []
      h[score] << i
    end
    h.values
  end

  def each_similar(list, &block)
    similar = []

    pairs = {}
    find_pairs(list).each do |p|
      p.each do |i|
        pairs[i] = p
      end
    end
    list.size.times do |i|
      (list.size - 1 - i).times do |j|
        a = list[i]
        b = list[i+j+1]
        diff = (a-b).abs

        n = Math.log2(diff)

        next if n % 1 != 0

        # need an odd difference
        next if (j+1) % 2 != 1

        # don't leave an odd number of rows

        after = pairs[i].select {|p| p > i && p < i+j+1}.size
        next if after > 0 && after % 2 == 1

        before = pairs[i+j+1].select {|p| p < i+j+1 && p > i}.size
        next if before > 0 && before % 2 == 1


        block.call n.to_i, i, i+j+1
      end
    end
  end

  def reflection(list, skip)

    pairs = find_pairs list

    pairs.each do |p|
      if p.size == 3
        x = [p.shift, p.first]
        pairs << x
      end
      while p.size % 2 == 0 && p.size > 2
        x = [p.shift, p.first]
        pairs << x
        x = [x.first, p.pop]
        pairs << x
        x = [p.last, x.last]
        pairs << x
      end
    end

    pairs = pairs.select {|p| p.size > 1}

    if pairs.empty?
      return 0
    end

    asc = pairs.sort_by(&:first)
    if asc.first[0] == 0
      targets = asc.select {|p| p[0] == asc.first[0]}.map {|p| p.sum / p.size + 1}

      targets.select {|t| t != skip }.each do |target|
        if asc.select {|p| p.sum / p.size + 1 == target }.map(&:first) == (0..target-1).to_a
          return target
        end
      end
    end

    desc = pairs.sort_by(&:last)
    if desc.last[1] == list.size-1
      targets = desc.select {|p| p[1] == desc.last[1]}.map {|p| p.sum / p.size + 1}
      targets.each do |target|
        if desc.select {|p| p.sum / p.size + 1 == target }.map(&:last) == (target..list.size-1).to_a
          return target
        end
      end
    end

    return 0
  end
end


i = 0
sum = 0
other_sum = 0
pattern = nil
g = ''

loop do
  line = STDIN.readline rescue nil
  if line.to_s.chomp.empty?
    r = pattern.row_reflection
    c = pattern.col_reflection

    sum += r*100 + c

    if true || r == 0 && c == 0
      if c != 0
        print "   " + ' '*(c-1)
        puts "vv"
      end

      g.each_line.with_index do |l,i|
        if r !=0 && ( i == r || i+1 == r )
          puts "=> #{l.chomp} <= (#{r})"
        else
          puts "   #{l}"
        end
      end
      if c != 0
        print "   " + ' '*(c-1)
        puts "^^ (#{c})"
      end

      trials = []
      pattern.row_similar do |j, i0, i1|
        trials += [[i0, j], [i1, j]]
      end
      pattern.col_similar do |i, j0, j1|
        trials += [[i, j0], [i, j1]]
      end

      s = []
      trials.each do |i,j|
        pattern.toggle! i, j
        r1 = pattern.row_reflection skip: r
        c1 = pattern.col_reflection skip: c

        if r1 != 0 && r1 != r
          s << [r1,0]
        elsif c1 != 0 && c1 != c
          s << [0,c1]
        end

        pattern.toggle! i, j
      end
      s.uniq!

      other_sum += s.first[0]*100 + s.first[1]

      puts

    end

    i = 0
    pattern = nil
    g = ''

    break if !line
    next
  end

  pattern ||= Pattern.new

  score = 0
  line.strip.each_char.with_index do |char,j|
    pattern.score! i, j if char == '#'
    score += 2**j if char == '#'
    g += char
  end
  g += "\n"

  i += 1
end

puts sum
puts other_sum
