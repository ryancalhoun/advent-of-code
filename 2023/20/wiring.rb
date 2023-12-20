class Wiring
  attr_reader :mod, :connections

  def initialize(bus, mod, connections)
    @bus = bus
    @mod = mod
    @connections = Hash[*(connections.zip([nil]*connections.size)).flatten]
  end
  def wire!(&block)
    @connections.keys.each do |key|
      receiver = block.call key
      @connections[key] = receiver.onreceive mod.name
    end
  end
  def trigger!(pulse)
    @connections.each do |key, sender|
      @bus.count! pulse
      out = sender.call pulse, mod.state

      @bus.enqueue key, out unless out.nil?
    end
  end
end

