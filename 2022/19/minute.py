class Minute:
  def __init__(self):
    self.resources = {
      'ore': 0,
      'clay': 0,
      'obsidian': 0,
      'geode': 0,
    }

  def can_afford(self, r):
    return all(self.resources[k] >= (r.get(k) or 0) for k in r)
