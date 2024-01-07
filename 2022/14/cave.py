from pile import Pile

def on_surface(l, p):
  if l:
    surfaces = [s for s in l if p in range(s[0], s[1]+1)]
    if len(surfaces) > 0:
      return (min([s[0] for s in surfaces]), max([s[1] for s in surfaces]))

class Cave:
  def __init__(self, source_x, source_y):
    self.source = (source_x, source_y)
    self.x_min = source_x
    self.x_max = source_x
    self.floors = {}
    self.walls = {}
    self.sand = {}
    self.count = 0

    self.inspect = []
    self.window = [0, 50]

  def parse_from(self, f):
    for line in f:
      p0 = ()
      for point in line.split('->'):
        p1 = tuple(int(c) for c in point.strip().split(','))

        if p0:
          self.add(p0, p1)

        p0 = p1

  def add(self, p0, p1):
    x0, x1 = sorted([p[0] for p in [p0, p1]])
    y0, y1 = sorted([p[1] for p in [p0, p1]])

    self.x_min = min(self.x_min, x0)
    self.x_max = max(self.x_max, x1) 

    if not self.floors.get(y0):
      self.floors[y0] = []
    if not (x0, x1) in self.floors[y0]:
      self.floors[y0].append((x0, x1))

    if y0 == y1:
      if not self.walls.get(x0):
        self.walls[x0] = []
      if not self.walls.get(x1):
        self.walls[x1] = []
      if not (y0, y1) in self.walls[x0]:
        self.walls[x0].append((y0, y1))
      if not (y0, y1) in self.walls[x1]:
        self.walls[x1].append((y0, y1))
    else:
      if not self.walls.get(x0):
        self.walls[x0] = []
      if not (y0, y1) in self.walls[x0]:
        self.walls[x0].append((y0, y1))

  def will_fall_to(self, p):
    for y in sorted(self.floors.keys()):
      if y > p[1] and on_surface(self.floors.get(y), p[0]):
        return (p[0], y)

  def is_in_path(self, p):
    if on_surface(self.floors.get(p[1]), p[0]):
      return True

    if on_surface(self.walls.get(p[0]), p[1]):
      return True

    return False

  def is_wall(self, p):
    x, y = p
    return on_surface(self.walls.get(x), y)

  def is_floor(self, p):
    x, y = p
    return on_surface(self.floors.get(y), x)

  def get_floor(self, p):
    x, y = p
    return on_surface(self.floors.get(y+1), x)

  def next_pile(self, p):
    p1 = self.will_fall_to(p)
    if not p1:
      return None
    pile = self.sand.get(p1)

    if not pile:
      pile = self.sand[p1] = Pile(p1)
    return pile

  def get_y_max(self):
    return max(self.floors.keys())

  def update_window(self, p):
    if p[1] > self.window[1] - 5:
      self.window[1] = min(self.get_y_max(), p[1] + 5)
      self.window[0] = self.window[1] - 50 

  def drop_sand(self, pause=None):

    p0 = self.source

    pile = self.next_pile(p0)
    last = None
    p0 = pile.first_pos()

    while True:
      self.inspect = [p0]

      p1s = pile.next_pos(p0)

      if pause and p0[1] >= self.window[0]:
        pause()

      p1 = p1s[0]
      if self.is_wall(p1) or self.is_floor(p1) or (last and p1 in last):
        p1 = p1s[-1]
        
        if self.is_wall(p1) or self.is_floor(p1) or (last and p1 in last):
          pile.add(p0)
          self.update_window(p0)
          self.count += 1
          break

      f = self.get_floor(p1)
      if f:
        edges = []
        if f[0] == p1[0] and p1[0] != p0[0]+1:
          edges.append(-1)
        if f[1] == p1[0] and p1[0] != p0[0]-1:
          edges.append(1)

        p1_best = None
        for edge in edges:
          n0 = (p1[0]+edge, p1[1])
          if n0 in pile:
            continue
          spillover = self.next_pile(n0)
          if not spillover:
            self.inspect = [n0]
            return False

          n1 = spillover.first_pos()

          if n1[1] >= p1[1]:
            if n1 == n0:
              pile.merge(spillover)
              p1_best = p1
            else:
              last = pile
              pile = spillover
              p1_best = n1
              break
        if p1_best:
          p1 = p1_best

      if p0 == p1:
        pile.add(p0)
        self.update_window(p0)
        self.count += 1
        break

      p0 = p1

    return True

  def __str__(self):
    s = ''
    s += '\033[H\033[2J'
    s += f'Placed {self.count} sand\n'
    y_min = max(0, self.window[0])
    y_max = min(self.window[1], max(self.floors.keys()))
    for y in range(y_min, y_max + 1):
      s += ('%3d: ' % y)
      for x in range(self.x_min, self.x_max+1):
        if (x,y) in self.inspect:
          s += '\033[93m@\033[0m'
          continue
        if y == 0 and x == 500:
          s += '+'
          continue
        if len([v for v in self.sand.values() if (x,y) in v]) > 0:
          s += '\033[33mO\033[0m'
          continue
        if self.is_in_path((x,y)):
          s += '#'
        else:
          s += ' '

      s += '\n'
    return s
