from minute import Minute
import copy

class Timeline:
  def __init__(self, blueprint, minutes):
    self.blueprint = blueprint
    self.i = 0
    self.t = []

    for t in range(0, minutes):
      m = Minute()
      m.resources['ore'] = t + 1
      self.t.append(m)

  def try_buy(self, r):
    i = self.index(r)
    if i not in range(0, len(self.t)-1):
      return None

    n = copy.deepcopy(self)
    n.i = i

    for k in self.blueprint[r]:
      for j in range(i, len(self.t)):
        n.t[j].resources[k] -= self.blueprint[r][k]
    for j in range(i+1, len(self.t)):
      n.t[j].resources[r] += j - i

    return n  

  def index(self, r):
    for i in range(self.i, len(self.t)-1):
      if self.t[i].can_afford(self.blueprint[r]):
        return i + 1
    return None
