class Facing:
  def __init__(self, f = 0):
    self.f = f

  def __radd__(self, other):
    return self.f + other

  def right(self):
    return Facing((self.f + 1) % 4)

  def left(self):
    return Facing((self.f - 1) % 4)

  def vertical(self):
    return self.f in (1, 3)

  def horizontal(self):
    return self.f in (0, 2)

  def distance(self, n):
    if self.horizontal():
      return (1 - self.f) * n
    else:
      return (2 - self.f) * n
