require_relative 'grid'

class App
  def initialize(part:)
    @part = part
    @g = Grid.new
  end

  def run(filename)
    File.open(filename) do |file|
      file.each_line.with_index do |line,i|
        line.strip.each_char.with_index do |char,j|
          if char == 'O'
            @g.add_rolling i, j
          elsif char == '#'
            @g.add_fixed i, j
          else
            @g.touch i, j
          end
        end
      end
    end

    if @part == 1
      @g.tilt_n!
      @g.load_score
    else
      @g.extrapolate!(1000000000)
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end


