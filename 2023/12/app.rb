require_relative 'sequence'

class App
  def initialize(part:)
    @part = part
  end
  def run(filename)
    total = 0
    File.open(filename) do |f|
      f.each_line do |line|
        m = /([#\.\?]+) ([\d,]+)/.match(line)
        s = Sequence.new(m[1], m[2].split(',').map(&:to_i))
        s.unfold!(5) unless @part == 1

        total += s.count_matches
      end
    end
    total
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
