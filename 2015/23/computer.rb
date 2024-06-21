class Register
  attr_reader :name
  attr_accessor :value
  def initialize(name, value=0)
    @name = name
    @value = value
  end
end

class Computer
  attr_reader :a, :b

  def initialize
    @ptr = 0
    @instructions = []

    @a = Register.new :a
    @b = Register.new :b
  end

  def output(reg)
    puts reg.value.to_s
  end

  def execute(&instruction)
    @instructions << instruction

    while @ptr < @instructions.size
      @ptr += @instructions[@ptr].call
    end
  end

  def hlf(reg)
    execute { reg.value /= 2; 1 }
  end
  def tpl(reg)
    execute { reg.value *= 3; 1 }
  end
  def inc(reg)
    execute { reg.value += 1; 1 }
  end
  def jmp(off)
    execute { off }
  end
  def jie(r, off)
    execute { r.value % 2 == 0 ? off : 1 }
  end
  def jio(r, off)
    execute { r.value == 1 ? off : 1 }
  end
end

def method_missing(name, *args, &block)
  if (@computer ||= Computer.new).respond_to?(name)
    @computer.send name, *args
  end
end
