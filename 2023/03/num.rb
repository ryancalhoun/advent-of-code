class Num
  attr_reader :value
  def initialize(digit, i, j)
    @value = digit
    @i = i
    @j = j
  end
  def append(digit)
    @value *= 10
    @value += digit
    @j += 1
  end
  def continues?(i, j)
    @i == i && @j == j - 1
  end
  def adj?(i, j)
    len = Math.log10(value).to_i + 1

    if (@i-1..@i+1).include?(i) && (@j-len..@j+1).include?(j)
      return true
    end
  end
end
