require_relative 'bet'
require_relative 'card'
require_relative 'hand'

require 'enumerator'

class App
  def initialize(part:)
    @part = part
    @bets = []
  end

  def run(filename)
    load_bets!(filename)
    total_winnings
  end

  def load_bets!(filename)
    @bets = File.open(filename) do |f|
      f.each_line.map do |line|
        cards, bet = line.split(' ')

        hand = Hand.new(cards.each_char.map {|char| Card.new(char, overrides) }, overrides)
        Bet.new(hand, bet.to_i)
      end
    end
  end

  def overrides
    if @part == 1
      {}
    else
      { 'J' => 1 }
    end
  end

  def total_winnings
    enum_for(:each_ranked_bet).map {|b, i| b*i}.inject(:+)
  end

  def each_ranked_bet
    @bets.sort.each_with_index do |b, i|
      yield b.amount, i+1
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
