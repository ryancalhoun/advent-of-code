require_relative 'pattern'

class App
  def initialize(part:)
    @part = part
    @sum = 0
  end

  def run(filename)
    File.open(filename) do |f|
      i = 0
      loop do
        line = f.readline rescue nil

        if line.to_s.chomp.empty?
          find_reflection!

          i = 0
          @pattern = nil
          break if !line
          next
        end

        @pattern ||= Pattern.new
        line.strip.each_char.with_index do |char,j|
          @pattern.score! i, j if char == '#'
        end
        i += 1
      end 
    end
    @sum
  end

  def find_reflection!
    r = @pattern.row_reflection
    c = @pattern.col_reflection

    if @part == 1
      @sum += r*100 + c
    else
      alt_r, alt_c = find_alternate_reflection r, c
      @sum += alt_r*100 + alt_c
    end
  end

  def find_alternate_reflection(r, c)
    trials = []
    @pattern.row_similar do |j, i0, i1|
      trials += [[i0, j], [i1, j]]
    end
    @pattern.col_similar do |i, j0, j1|
      trials += [[i, j0], [i, j1]]
    end

    s = []
    trials.each do |i,j|
      @pattern.toggle! i, j
      r1 = @pattern.row_reflection skip: r
      c1 = @pattern.col_reflection skip: c

      if r1 != 0 && r1 != r
        s << [r1,0]
      elsif c1 != 0 && c1 != c
        s << [0,c1]
      end

      @pattern.toggle! i, j
    end
    s.uniq!

    [s.first[0], s.first[1]]
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end

