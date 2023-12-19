class Rule
  def initialize(cat, dest, &block)
    @cat, @dest = cat, dest
    @block = block
  end
  def self.parse(str)
    cat, cmp, limit, dest = /([xmas])([<>])(\d+):(\w+)/.match(str).captures

    new cat, dest do |val|
      val.send cmp, limit.to_i
    end
  end
  def call(object)
    @dest if @block.call object[@cat]
  end
end


