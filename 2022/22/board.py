from line import Line

class Board:
  def __init__(self):
    self.rows = []
    self.cols = []

  def size(self):
    return (len(self.rows), len(self.cols))

  def shape(self, scale):
    s = []
    for j in range(len(self.rows)//scale):
      row = self.rows[j*scale]
      s.append([])
      for i in range(len(self.cols)//scale):
        s[-1].append(i * scale in row)
    return s

  def first(self):
    return (self.rows[0].start, 0)

  def move(self, p, step):
    i, j = p
    dist, face = step

    if face.horizontal():
      i = self.rows[j].move(i, face.distance(dist))
    else:
      j = self.cols[i].move(j, face.distance(dist))

    return (i, j)

  def open(self, i, j):
    if len(self.rows) == j:
      self.rows.append(Line())

    if len(self.cols) == i:
      self.cols.append(None)
    elif len(self.cols) < i:
      self.cols = [None] * (i+1)
    if not self.cols[i]:
      self.cols[i] = Line()

    self.rows[j].open(i)
    self.cols[i].open(j)

  def wall(self, i, j):
    self.open(i, j)
    
    self.rows[j].wall(i)
    self.cols[i].wall(j)
