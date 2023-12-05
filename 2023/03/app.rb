class Num
  attr_reader :value, :i, :j
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
  def adj?(sym)
    len = Math.log10(value).to_i + 1

    if (i-1..i+1).include?(sym.i) && (j-len..j+1).include?(sym.j)
      return true
    end
  end
end

class Sym
  attr_reader :symbol, :i, :j
  def initialize(symbol, i, j)
    @symbol = symbol
    @i = i
    @j = j
    @parts = []
  end
  def add_part(part)
    if @parts.none? {|p| p.value == part.value}
      @parts << part
    end
  end
  def is_gear?
    symbol == '*' && @parts.size == 2
  end
  def ratio
    @parts.map(&:value).inject(:*)
  end
end

class Schematic
  def initialize
    @numbers = {}
    @symbols = []
  end
  def add_digit(digit, i, j)
    current_row = (@numbers[i] ||= [])
    current = current_row.last
    if current && current.i == i && current.j == j - 1
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
      adjacent = @numbers.slice(sym.i-1, sym.i, sym.i+1).values.flatten.select {|num| num.adj?(sym)}
      adjacent.each do |num|
        sym.add_part num
        yield num
      end
    end
  end
end

sch = Schematic.new

i = 0
STDIN.each_line do |line|
  j = 0
  line.chomp.each_char do |char|
    case char
    when '.'
    when '0'..'9'
      sch.add_digit char.to_i, i, j
    else
      sch.add_symbol char, i, j
    end

    j += 1 
  end

  i += 1
end

sum = 0
sch.each_gear do |gear|
   sum += gear.ratio
end

puts sum
