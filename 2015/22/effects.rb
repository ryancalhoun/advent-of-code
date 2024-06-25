class Effects
  def initialize
    @e = {}
  end

  def add(e, source)
    @e[e] = source
  end

  def remove(e)
    @e.delete e
  end

  def active_at(time)
    @e.select {|e,s| e.active_at?(time) }
  end

  def is_active?(time, kind)
    ! active_at(time).select {|e,s| e.is_a?(kind) }.empty?
  end
end
