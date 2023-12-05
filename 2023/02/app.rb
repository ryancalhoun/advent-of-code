def is_possible?(game)
  game['red'] <= 12 && game['green'] <= 13 && game['blue'] <= 14 && game.keys.size <= 3
end
def get_power(game)
  game.values.inject(:*) 
end

sum = 0

STDIN.each_line do |line|
  id, draws = /Game (\d+): (.*)/.match(line).captures

  max = {}

  draws.split(';').each do |draw|
    colors = draw.split(',')
    colors.each do |cubes|
      num, color = cubes.chomp.split(' ')
      num = num.to_i

      if num > max[color].to_i
        max[color] = num
      end
    end
  end

  if is_possible?(max)
  #  sum += id.to_i
  end
  sum += get_power(max)
end

puts sum
