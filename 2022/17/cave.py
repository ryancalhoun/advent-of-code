from rock import Rock
from sequence import Sequence

class Cave:
  def __init__(self, jet, shape):
    self.jet = jet
    self.shape = shape
    self.tower = []
    self._top = 0

  def top(self):
    return self._top

  def drop(self, n):
    s = Sequence(10)
    for i in range(n):
      self.drop_one()
      s.add(self.top())

      if s.pattern():
        self._top = s[n-1]
        break

  def drop_one(self):
    r = Rock(next(self.shape))
    r.move(2, self.top() + 3)

    while True:
      jet = next(self.jet)
      r.x += jet
      if r.left() < 0 or r.right() > 6 or self.intersecting_with(r):
        r.x -= jet
      r.y -= 1
      if r.bottom() < 0 or self.intersecting_with(r):
        r.y += 1
        break
    self.tower.append(r)
    self.tower.sort()
    self._top = self.tower[-1].top()

  def intersecting_with(self, r):
    for i in range(len(self.tower)):
      rock = self.tower[-1-i]
      if rock.top() < r.bottom():
        break
      if rock.intersect(r):
        return True

