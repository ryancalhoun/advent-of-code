require_relative 'branch'
require_relative 'network'
require_relative 'path'

class App
  def initialize(part:)
    @part = part
  end
  def run(filename)
    network = Network.new
    paths = []

    File.open(filename) do |f|
      directions = f.readline.scan(/R|L/)

      f.each_line do |line|
        node, left, right = /(\w+)\s*=\s*\((\w+),\s*(\w+)\)/.match(line)&.captures
        network[node] = Branch.new(left, right) if node

        if is_starting_node?(node)
          paths << Path.new(node, ->(stop) { is_stopping_node?(stop) }, directions) 
        end
      end
    end

    raise 'no starting node' if paths.empty?

    paths.map do |path|
      network.follow path
      path.length
    end.reduce(1, :lcm)
  end

  def is_starting_node?(node)
    if @part == 1
      node == 'AAA'
    else
      node && node.end_with?('A')
    end
  end
  def is_stopping_node?(node)
    if @part == 1
      node == 'ZZZ'
    else
      node.end_with?('Z')
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
