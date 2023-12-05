pile = Hash.new(0)

STDIN.each_line do |line|
  card, numbers = line.split(':')
  winning, have = numbers.split('|').map do |s|
    s.scan(/\d+/).map(&:to_i)
  end

  cardnum = /\d+/.match(card)[0].to_i

  matches = 0
  have.each do |h|
    matches += 1 if winning.include?(h)
  end

  copies = pile[cardnum] += 1

  matches.times do |m|
    pile[cardnum+matches-m] += copies
  end

end

puts pile.values.inject(:+)
