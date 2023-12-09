require_relative 'sequence'

class App
  def initialize(part:)
    @part = part
  end

  def run(filename)
    sum = 0

    File.open(filename) do |f|
      f.each_line do |line|
        s = Sequence.new(line.scan(/-?\d+/).map(&:to_i))

        sum += if @part == 1
          s.next_value
        else
          s.prev_value
        end
      end
    end

    sum
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
