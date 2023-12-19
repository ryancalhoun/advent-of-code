require_relative 'workflow'
require_relative 'destination'
require_relative 'simulation'

class App
  def initialize(part:)
    @part = part
  end

  def run(filename)
    workflows = {}
    objects = []

    parse = ->(line) {
      w = Workflow.parse line
      workflows[w.name] = w
    }
    File.open(filename) do |f|
        f.each_line do |line|
        if line.strip.empty?
          parse = ->(line) {
            objects << Hash[*line.scan(/([xmas])=(\d+)/).map {|cat, val| [cat, val.to_i]}.flatten]
          }
        else
          parse.call line
        end
      end
    end
    workflows['A'] = Destination.new
    workflows['R'] = Destination.new

    objects = Simulation.new unless @part == 1

    objects.each do |obj|
      name = 'in'
      while name
        w = workflows[name]
        name = w.process obj
      end
    end
    workflows['A'].sum
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
