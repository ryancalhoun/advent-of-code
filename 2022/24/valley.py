class Direction:
  def __init__(self):
    self.line = {}

  def add(self, i, j):
    if not self.line.get(i):
      self.line[i] = set()

    self.line[i] |= {j}

  def get(self, i, j):
    return j in (self.line.get(i) or set())

class Valley:
  def __init__(self):
    self.north = Direction()
    self.south = Direction()
    self.east = Direction()
    self.west = Direction()

    self.openings = []
    self.width = 0
    self.height = 0

  def read(self, f):
    y = 0
    for line in f:

      if line.count('#') > 2:
        self.openings.append((line.index('.'), y))

      x = 0

      for char in line.strip():
        if char == '^':
          self.north.add(x, y)
        elif char == 'v':
          self.south.add(x, y)
        elif char == '<':
          self.west.add(y, x)
        elif char == '>':
          self.east.add(y, x)

        x += 1
      y += 1

    self.width = x
    self.height = y

  def start(self):
    return self.openings[0]

  def end(self):
    return self.openings[1]

  def available(self, x, y, t):
    if (x,y) in self.openings:
      return True

    if not x in range(1, self.width-1) or y not in range(1, self.height-1):
      return False

    if self.north.get(x, (y+t-1) % (self.height-2) + 1):
      return False
    elif self.south.get(x, (y-t-1) % (self.height-2) + 1):
      return False
    elif self.east.get(y, (x-t-1) % (self.width-2) + 1):
      return False
    elif self.west.get(y, (x+t-1) % (self.width-2) + 1):
      return False

    return True

  def cross(self, start, end, t = 0):
    m = set({start})
    while True:
      n = set()
      for x, y in m:
        if (x,y) == end:
          return t

        if self.available(x, y, t+1):
          n |= {(x, y)}
        if self.available(x, y-1, t+1):
          n |= {(x, y-1)}
        if self.available(x, y+1, t+1):
          n |= {(x, y+1)}
        if self.available(x-1, y, t+1):
          n |= {(x-1, y)}
        if self.available(x+1, y, t+1):
          n |= {(x+1, y)}

      m = n
      t += 1
