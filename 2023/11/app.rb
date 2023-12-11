require_relative 'universe'

class App
  def initialize(part:)
    @universe = Universe.new rate: (part == 1 ? 2 : 1000000)
  end
  def run(filename)
    File.open(filename) do |f|
      f.each_line.with_index do |line,i|
        line.chomp.each_char.with_index do |char,j|
          if char == '#'
            @universe.add_galaxy Galaxy.new i, j
          end
        end
      end
    end

    @universe.expand!
    @universe.find_shortest_paths.inject(:+)
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
