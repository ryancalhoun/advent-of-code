require_relative 'lagoon'

class App
  def initialize(part:)
    @part = part
  end
  def run(filename)

    lagoon = Lagoon.new
    File.open(filename) do |f|
      f.each_line do |line|
        dir, n, color = /([RDLU]) (\d+) \(#([0-9a-f]+)\)/.match(line).captures

        decode_dir = "RDLU"
        if @part != 1
          dir = decode_dir[color[5].to_i]
          n = color[0..4].to_i(16)
        end

        lagoon.send(dir)
        lagoon.dig!(n.to_i)
      end
    end

    lagoon.total_volume
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
