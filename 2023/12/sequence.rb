class Sequence
  attr_reader :score
  def initialize(text, numbers)
    @text, @numbers = text, numbers
  end
  def unfold!(n)
    @text = ([@text] * 5).join('?')
    @numbers *= 5
  end
  def count_matches
    states = '.'

    @numbers.each do |n|
      states += '#' * n + '.'
    end

    d = { 0 => 1 }
    n = Hash.new(0)

    @text.each_char do |c|
      d.each do |k,v|
        n[k+1] += d[k] if k+1 < states.size && (states[k+1] == c || c == '?')
        n[k] += d[k] if states[k] == '.' && c != '#'
      end

      d = n
      n = Hash.new(0)
    end

    d[states.size - 1] + d[states.size - 2]
  end
end
