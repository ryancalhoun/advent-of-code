class Network
  def initialize
    @g = {}
  end
  def [](node)
    @g[node]
  end
  def []=(node, branch)
    @g[node] = branch
  end
  def follow(path)
    until path.done?
      path.go_to @g[path.current].send path.next_direction
    end
  end
end

