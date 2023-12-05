require_relative 'schematic'

class App
  def initialize(part:)
    @part = part
    @sch = Schematic.new
  end

  def run(filename)
    self.load(filename)

    sum = 0
    if @part == 1
      @sch.each_part do |part|
         sum += part.value
      end
    else
      @sch.each_gear do |gear|
         sum += gear.ratio
      end
    end
    sum
  end

  def load(filename)
    i = 0
    File.open(filename).each_line do |line|
      j = 0
      line.chomp.each_char do |char|
        case char
        when '.'
        when '0'..'9'
          @sch.add_digit char.to_i, i, j
        else
          @sch.add_symbol char, i, j
        end

        j += 1
      end

      i += 1
    end
  end

end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
