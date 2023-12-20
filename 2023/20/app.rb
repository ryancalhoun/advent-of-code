require_relative 'bus'
require_relative 'broadcast'
require_relative 'conjunction'
require_relative 'flipflop'

class App
  def initialize(part:)
    @part = part
    @bus = Bus.new
  end

  def run(filename)
    File.open(filename) do |f|
      f.each_line do |line|
        if m = /broadcaster -> (.*)/.match(line)
          add Broadcast.new, m[1]
        elsif m = /%(\w+) -> (.*)/.match(line)
          add Flipflop.new(m[1]), m[2]
        elsif m = /&(\w+) -> (.*)/.match(line)
          add Conjunction.new(m[1]), m[2]
        end
      end
    end

    @bus.wire!

    if @part == 1
      1000.times do |i|
        @bus.push!
        @bus.process!
      end
      @bus.low * @bus.high
    else
      predictor = @bus.predictor

      until predictor.done?
        @bus.push!
        predictor.cycle = @bus.pushes

        @bus.process!
      end

      predictor.prediction
    end
  end

  def add(mod, str)
    @bus.add mod, str.split(',').map(&:strip)
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
