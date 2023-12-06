class Card
  attr_reader :num, :winning, :have
  def initialize(num, winning, have)
    @num = num
    @winning = winning
    @have = have
  end

  def self.parse(str)
    card, numbers = str.split(':')
    winning, have = numbers.split('|').map do |s|
      s.scan(/\d+/).map(&:to_i)
    end

    cardnum = /\d+/.match(card)[0].to_i

    self.new cardnum, winning, have
  end

  def count_matches
    have.select {|h| winning.include?(h) }.size
  end

  def points
    m = count_matches
    if m == 0
      0
    else
      2 ** (m-1)
    end
  end
end
