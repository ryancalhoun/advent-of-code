from facing import Facing

class Path:
  def __init__(self):
    self.i = 0
    self.j = 0
    self.steps = []

  def add(self, char):
    if not self.steps:
      self.steps.append((0, Facing()))

    d, f = self.steps[-1]

    if char == 'R':
      self.steps.append((0, f.right()))
    elif char == 'L':
      self.steps.append((0, f.left()))
    else:
      self.steps[-1] = (d*10 + int(char), f)

