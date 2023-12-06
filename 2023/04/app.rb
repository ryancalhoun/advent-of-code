require_relative 'card'

class App
  def initialize(part:)
    @part = part
  end

  def run(filename)
    part = if @part == 1
      lambda do |&block|
        points = 0
        block.call do |card|
          points += card.points
        end
        points
      end
    else
      lambda do |&block|
        pile = Hash.new(0)
        block.call do |card|
          copies = pile[card.num] += 1
          matches = card.count_matches
          matches.times do |m|
            pile[card.num+matches-m] += copies
          end
        end
        pile.values.inject(:+)
      end
    end

    part.call do |&block|
      File.open(filename).each_line do |line|
        block.call Card.parse line
      end
    end
  end
end


if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
