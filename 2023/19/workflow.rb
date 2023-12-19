require_relative 'rule'

class Workflow
  attr_reader :name
  def initialize(name, rules, final)
    @name = name
    @rules = rules
    @final = final
  end
  def self.parse(line)
    name, rules = /(\w+)\{(.+)\}/.match(line).captures
    rules = rules.split(',')
    final = rules.pop
    new name, rules.map {|r| Rule.parse r}, final
  end

  def process(object)
    dest = nil
    @rules.each do |rule|
      dest = rule.call object
      break if dest
    end
    dest || @final
  end
end


