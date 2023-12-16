require_relative 'grid'

class App
  def initialize(part:)
    @part = part
    @g = Grid.new
  end

  def run(filename)
    load_grid! filename

    if @part == 1
      @g.shoot! :right, 0, -1
      @g.count_visited
    else
      max = 0

      trial = ->(dir, i, j) {
        @g.reset!
        @g.shoot! dir, i, j
        max = [max, @g.count_visited].max
      }

      @g.height.times do |i|
        trial[:right, i, -1]
        trial[:left, i, @g.width]
      end
      @g.width.times do |j|
        trial[:down, -1, j]
        trial[:up, @g.height, j]
      end

      max
    end
  end

  def load_grid!(filename)
    File.open(filename).each_line.with_index do |line,i|
      line.strip.each_char.with_index do |char,j|
        case char
        when '/'
          @g.add_left_mirror! i, j
        when '\\'
          @g.add_right_mirror! i, j
        when '|'
          @g.add_h_splitter! i, j
        when '-'
          @g.add_v_splitter! i, j
        else
          @g.touch! i, j
        end
      end
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end


