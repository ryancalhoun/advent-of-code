from line import Line

class Board:
  def __init__(self):
    self.rows = []

  def size(self):
    return (self.height(), self.width())

  def height(self):
    return len(self.rows)

  def width(self):
    return max(r.stop for r in self.rows) + 1

  def shape(self, scale):
    s = []

    h, w = self.size()

    for j in range(h // scale):
      row = self.rows[j * scale]
      s.append([])
      for i in range(w // scale):
        s[-1].append(i * scale in row)

    return tuple(tuple(r for r in row) for row in s)

  def first(self):
    return (self.rows[0].start, 0)

  def move(self, p):
    i, j = p
    return self.rows[j].can_move(i)

  def open(self, i, j):
    if len(self.rows) == j:
      self.rows.append(Line())

    self.rows[j].open(i)

  def wall(self, i, j):
    self.open(i, j)
    self.rows[j].wall(i)
