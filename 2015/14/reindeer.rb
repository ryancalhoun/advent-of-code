class Reindeer
  attr_reader :distance, :score

  def initialize(name, speed, burst, rest)
    @name, @speed, @burst, @rest = name, speed, burst, rest
    @distance = 0
    @score = 0
  end

  def fly!(time)
    complete = (time / (@burst + @rest)).to_i
    partial = time - complete * (@burst + @rest)

    @distance = complete * @speed * @burst

    if partial > @burst
      @distance += @speed * @burst
    else
      @distance += @speed * partial
    end

    @distance
  end

  def leading!
    @score += 1
  end
end
