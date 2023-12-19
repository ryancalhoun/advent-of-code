class Rule
  def initialize(key, dest, &block)
    @key, @dest = key, dest
    @block = block
  end
  def self.parse(str)
    key, cmp, limit, dest = /([xmas])([<>])(\d+):(\w+)/.match(str).captures

    new key, dest do |val|
      val.send cmp, limit.to_i
    end
  end
  def call(object)
    @dest if @block.call object[@key]
  end
end


