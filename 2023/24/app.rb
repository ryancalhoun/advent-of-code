require_relative 'stone'
require_relative 'area'

class App
  def initialize(part:, bounds: 200000000000000..400000000000000)
    @part = part
    @bounds = bounds
  end

  def run(filename)
    stones = []
    File.open(filename) do |file|
      file.each_line do |line|
        stones << Stone.parse(line)
      end
    end
    area = Area.new stones
    if @part == 1
      area.future_intersections_within @bounds
    else
      x, y, z = area.find_magic_line
      x + y + z
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end


