class App

  def initialize(part:)
    @part = part
  end

  def run(filename)
    sum = 0
    File.open(filename) do |f|
      f.each_line do |line|
        if @part == 1
          sum += id_of_possible_game(line) || 0
        else
          sum += power_of_min_cubes(line)
        end
      end
    end
    sum
  end

  def id_of_possible_game(line)
    id, game = str_to_game(line)
    throws = str_to_throws(game).map {|th| str_to_colors(th) }
    id if all_throws_possible?(throws)
  end

  def all_throws_possible?(throws)
    throws.all? {|game| is_game_possible?(game) }
  end

  def power_of_min_cubes(line)
    id, game = str_to_game(line)
    throws = str_to_throws(game).map {|th| str_to_colors(th) }
    get_power(get_max(throws))
  end

  def get_max(throws)
    max = {}
    throws.each do |game|
      game.each do |color,value|
        if (max[color] ||= 0) < value
          max[color] = value
        end
      end
    end
    max
  end

  def get_power(game)
    game.values.inject(:*) 
  end

  def is_game_possible?(game)
    (game['red'] || 0) <= 12 && (game['green'] || 0 ) <= 13 && (game['blue'] || 0) <= 14 && game.keys.size <= 3
  end

  def str_to_colors(str)
    h = {}
    str.split(',').each do |cubes|
      num, color = cubes.split(' ')
      num = num.to_i
      h[color] = num
    end
    h
  end

  def str_to_throws(str)
    str.split(';').map(&:strip)
  end

  def str_to_game(str)
    id, throws = /Game (\d+): (.*)/.match(str).captures
    return id.to_i, throws
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
