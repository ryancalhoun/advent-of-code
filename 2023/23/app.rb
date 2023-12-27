require_relative 'forest'
require_relative 'trail_map'

class App
  def initialize(part:)
    @part = part
  end

  def run(filename)
    forest = Forest.new
    File.open(filename) do |file|
      file.each_line do |line|
        forest << line.strip.each_char.to_a
      end
    end

    map = TrailMap.new
    map.trace_paths! forest
    map.strip_uphill! if @part == 1
    map.find_longest_path
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
