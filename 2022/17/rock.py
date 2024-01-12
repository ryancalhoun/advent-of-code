class Rock:
  def __init__(self, points):
    self._points = points
    self.x = 0
    self.y = 0
    self.w = max(p[0] for p in points) + 1
    self.h = max(p[1] for p in points) + 1

  def move(self, x, y):
    self.x = x
    self.y = y

  def bottom(self):
    return self.y

  def left(self):
    return self.x

  def right(self):
    return self.x + self.w - 1

  def top(self):
    return self.y + self.h

  def __lt__(self, other):
    return self.top() < other.top()

  def points(self):
    return [(self.x + p[0], self.y + self.h - p[1]) for p in self._points]

  def intersect(self, other):
    return any(p in self.points() for p in other.points())
