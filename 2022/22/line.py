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

  def move(self, i, n):
    s = n > 0 and 1 or -1    
    while n != 0 and i + s not in self.walls:
      i += s
      if i > self.stop:
        if self.start in self.walls:
          i = self.stop
        else:
          i = self.start
      if i < self.start:
        if self.stop in self.walls:
          i = self.start
        else:
          i = self.stop
      n -= s

    return i
