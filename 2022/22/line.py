class Line:
  def __init__(self):
    self.walls = set()
    self.start = None
    self.stop = None

  def __contains__(self, i):
    return i in range(self.start, self.stop+1)

  def open(self, i):
    if self.start == None:
      self.start = i
    self.stop = i

  def wall(self, i):
    self.open(i)
    self.walls |= {i}

  def can_move(self, i):
    return i in range(self.start, self.stop+1) and not i in self.walls

  def move(self, i, n):
    s = n > 0 and 1 or -1    

    while n != 0 and i + s not in self.walls:
      if i + s < self.start or i + s > self.stop:
        return i, n
      i += s
      n -= s

    return i, 0
