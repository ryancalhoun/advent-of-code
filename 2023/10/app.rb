require_relative 'grid'

class App
  def initialize(part:)
    @part = part
    @grid = Grid.new
  end
  def run(filename)
    File.open(filename) do |f|
      f.each_line.with_index do |line,i|
        line.chomp.each_char.with_index do |c,j|
          @grid.at(i, j).add c
        end
      end
    end

    @grid.find_loop!
    if @part == 1
      @grid.path_length / 2
    else
      @grid.find_enclosed!
      @grid.enclosed.size
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
