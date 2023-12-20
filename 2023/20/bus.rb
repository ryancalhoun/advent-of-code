require_relative 'wiring'
require_relative 'broadcast'
require_relative 'predictive_counter'
require 'ostruct'

class Bus
  attr_reader :pushes

  def initialize
    @modules = {}
    @outputs = {}
    @sending = []
    @sent = Hash.new(0)

    button = OpenStruct.new name: 'button', state: nil
    @button = Wiring.new(self, button, [Broadcast.name])
    @pushes = 0
  end

  def add(mod, connections)
    @modules[mod.name] = Wiring.new(self, mod, connections)
  end

  def enqueue(conn, pulse)
    @sending << [conn, pulse]
  end

  def wire!
    @button.wire! do |bc|
      @modules[bc].mod
    end

    @modules.values.each do |wiring|
      wiring.wire! do |conn|
        if m = @modules[conn]
          m.mod
        else
          w = Wiring.new(self, PredictiveCounter.new, [])
          @modules[conn] = @outputs[conn] = w

          w.mod
        end
      end
    end
  end

  def push!
    @pushes += 1
    @button.trigger! false
  end

  def process!
    until @sending.empty?
      conn, pulse = @sending.shift
      @modules[conn].trigger! pulse
    end
  end

  def count!(pulse)
    @sent[pulse] += 1
  end
  def low
    @sent[false]
  end
  def high
    @sent[true]
  end

  def predictors
    @outputs.each do |k,wiring|
      yield k, wiring.mod
    end
  end
  def predictor(name=nil)
    if name
      @outputs[name].mod
    else
      @outputs.values.first.mod
    end
  end

end

