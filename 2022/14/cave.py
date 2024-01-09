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
    self.bubbles = {}
    self.count = 0

    self.inspect = []
    self.window = [0, 0]

  def parse_from(self, f):
    for line in f:
      p0 = ()
      for point in line.split('->'):
        p1 = tuple(int(c) for c in point.strip().split(','))

        if p0:
          self.add(p0, p1)

        p0 = p1

  def set_window(self, w):
    if w < 0:
      self.window[0] = 0
      self.window[1] = self.get_y_max()
    else:
      self.window[1] = w

  def add(self, p0, p1):
    x0, x1 = sorted([p[0] for p in [p0, p1]])
    y0, y1 = sorted([p[1] for p in [p0, p1]])

    self.x_min = min(self.x_min, x0)
    self.x_max = max(self.x_max, x1) 

    if not self.floors.get(y0):
      self.floors[y0] = []
    if not (x0, x1) in self.floors[y0]:
      self.floors[y0].append((x0, x1))

    if y0 != y1:
      if not self.walls.get(x0):
        self.walls[x0] = []
      if not (y0, y1) in self.walls[x0]:
        self.walls[x0].append((y0, y1))

  def add_bubbles(self):
    for y in sorted(self.floors):
      floors = sorted(self.floors[y], key=lambda x: x[0])

      adjoining = []
      for f in floors:
        if len(adjoining) > 0 and (f[0] == adjoining[-1][1] or (f[0] == adjoining[-1][1] + 2 and (f[0]-1, y) in self.bubbles)):
          adjoining[-1] = [adjoining[-1][0], f[1]]
        else:
          adjoining.append(f)
          while self.bubbles.get((adjoining[-1][0]-1, y)):
            adjoining[-1] = (adjoining[-1][0]-1, adjoining[-1][1])

      for f in adjoining:
        x_min, x_max = f
        n = x_max - x_min - 1

        left = {}
        if len([w for w in (self.walls.get(x_min) or []) if w[0] == y and w[1] > y]) > 0:
          for r in range(y, y+n+1):
            left[r] = x_min

        right = {}
        if len([w for w in (self.walls.get(x_max) or []) if w[0] == y and w[1] > y]) > 0:
          for r in range(y, y+n+1):
            right[r] = x_max

        bottom = {}
        for j in range(n):
          for i in range(n):
            x1 = x_min + i + 1
            y1 = y + j + 1

            if not left.get(y1) and j > i:
              continue
            if not right.get(y1) and (n-1-j) < i:
              break

            if self.is_floor((x1, y1)):
              if not x1 in bottom:
                bottom[x1] = y1
              continue
            if x1 in bottom and bottom.get(x1) < y1:
              continue

            self.bubbles[(x1, y1)] = True


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
    size = self.window[1] - self.window[0]
    if size > 0 and p[1] > self.window[1] - 5:
      self.window[1] = min(self.get_y_max(), p[1] + 5)
      self.window[0] = self.window[1] - size

  def drop_sand(self, pause=None):

    p0 = self.source
    pile = self.next_pile(p0)

    last = None
    p0 = pile.first_pos()

    while True:
      self.inspect = [p0]

      p1s = pile.next_pos(p0)

      if pause and self.window and p0[1] >= self.window[0]:
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
        if p0 == self.source:
          return False
        pile.add(p0)
        self.update_window(p0)
        self.count += 1
        break

      p0 = p1

    return True

  def count_infinite_triangle(self):
    h = self.get_y_max() + 2

    sand = h * h

    for y in range(h):
      for x in range(self.x_min, self.x_max + 1):
        if self.is_in_path((x, y)) or (x, y) in self.bubbles:
          sand -= 1

    return sand

  def is_sand(self, x, y):
    if self.bubbles:
      h = y - self.source[1]
      w = x - self.source[0]
      return abs(w) <= h and not self.is_in_path((x, y)) and not (x,y) in self.bubbles
    elif self.sand:
      return len([v for v in self.sand.values() if (x,y) in v]) > 0

  def __str__(self):
    s = ''
    s += '\033[H\033[2J'
    if not self.bubbles:
      s += f'Placed {self.count} sand\n'
    y_min = max(0, self.window[0])
    y_max = min(self.window[1], self.get_y_max())
    for y in range(y_min, y_max + 2):
      s += ('%3d: ' % y)
      for x in range(self.x_min-5, self.x_max+6):
        if (x,y) in self.inspect:
          s += '\033[93m@\033[0m'
          continue
        if self.is_sand(x, y):
          s += '\033[33mO\033[0m'
          continue
        if y == 0 and x == 500:
          s += '+'
          continue
        if self.is_in_path((x,y)):
          s += '#'
        else:
          s += ' '

      s += '\n'
    return s
