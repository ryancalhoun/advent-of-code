class Sym
  attr_reader :i, :j
  def initialize(symbol, i, j)
    @symbol = symbol
    @i = i
    @j = j
    @parts = []
  end
  def add_part(part)
    if ! @parts.include?(part)
      @parts << part
    end
  end
  def is_gear?
    @symbol == '*' && @parts.size == 2
  end
  def ratio
    @parts.inject(:*)
  end
end
