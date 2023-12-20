class Broadcast
  def self.name
    'broadcaster'
  end
  def name
    self.class.name
  end
  def onreceive(conn)
    ->(pulse, state) do
      pulse
    end
  end
  def state
    nil
  end
end
