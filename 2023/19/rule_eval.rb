class RuleEval
  def initialize(object, key)
    @object = object
    @key = key
  end
  def <(limit)
    @object.lt(limit, @key)
  end  
  def >(limit)
    @object.gt(limit, @key)
  end  
end

