class Pile:
  def __init__(self, p):
    self.x, self.y = p
    self._top = {}
    self._children = {}
    self._infinite = False

  def get(self, x):
    ys = self._top.get(x) or []

    for s in self._children.values():
      y = s.get(x)
      if y:
        ys.append(y)

    if len(ys) > 0:
      return min(ys)

  def add(self, p):
    x, y = p
    if not x in self._top:
      self._top[x] = [y]
    else:
      self._top[x].append(y)

  def __contains__(self, p):
    x, y = p

    ys = self._top.get(x)
    if ys and y in ys:
      return True

    for s in self._children.values():
      if p in s:
        return True

    return False

  def __hash__(self):
    return hash((self.x, self.y))

  def size(self):
    return sum([len(x) for x in self._top.values()])

  def first_pos(self):
    y0 = self.get(self.x)
    return (self.x, (y0 or self.y) - 1)

  def next_pos(self, p):
    x, y = p

    y0 = self.get(x)
    ym = self.get(x-1)
    yp = self.get(x+1)

    if not y0 or (ym and yp and y0 >= ym and y0 >= yp):
      return [(x, y)]

    pos = []

    if not ym or ym > y0:
      pos.append((x-1, y+1))

    if not yp or yp > y0:
      pos.append((x+1, y+1))

    return pos

  def merge(self, child):
    self._children[child] = child

  def be_infinite(self):
    self._infinite = True
