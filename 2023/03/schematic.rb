require_relative 'num'
require_relative 'sym'

class Schematic
  def initialize
    @numbers = {}
    @symbols = []
  end
  def add_digit(digit, i, j)
    current_row = (@numbers[i] ||= [])
    current = current_row.last
    if current && current.continues?(i, j)
      current.append digit
    else
      current_row << Num.new(digit, i, j)
    end
  end
  def add_symbol(symbol, i, j)
    @symbols << Sym.new(symbol, i, j)
  end

  def each_part(&block)
    _each_symbol &block
  end
  def each_gear
    _each_symbol {}

    @symbols.select {|sym| sym.is_gear?}.each do |sym|
      yield sym
    end
  end

  private
  def _each_symbol
    @symbols.each do |sym|
      adjacent = @numbers.slice(sym.i-1, sym.i, sym.i+1).values.flatten.select {|num| num.adj?(sym.i, sym.j)}
      adjacent.each do |num|
        sym.add_part num.value
        yield num
      end
    end
  end
end

