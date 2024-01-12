require_relative 'trial'

class App
  def initialize(part:)
    @part = part
  end
  def run(filename)
    total = 0
    other = 0
    File.open(filename) do |f|
      f.each_line do |line|
        puts line
        t = Trial.parse(line)
        t.unfold! unless @part == 1
        t.run!

        t_sum = t.count_arrangements
        p_sum = t.count_by_pairs

        if t_sum != p_sum
        #  puts "#{t_sum} != #{p_sum}"
        #  exit
        end
  
        total += t_sum
        other += p_sum
      end
    end
    puts "Other=##{other}"
    total
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
