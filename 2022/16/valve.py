class Valve:

  def __init__(self, name, rate, neighbors, dist={}):
    self.name = name
    self.rate = rate
    self.neighbors = neighbors
    self.dist = dist.copy()

  def visit(self, n, d):
    d0 = self - n
    if not d0 or d < d0:
      self.dist[n] = d
      return True

  def __sub__(self, val):
    if str(val) == self.name:
      return 0
    return self.dist.get(str(val))

  def __mul__(self, val):
    return Valve(self.name, self.rate * int(val), self.neighbors, self.dist)

  def __repr__(self):
    return f'{self.name}@{self.rate}'
  def __int__(self):
    return self.rate
  def __hash__(self):
    return hash(self.name)
  def __eq__(self, other):
    return self.name == other.name
