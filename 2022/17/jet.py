class Jet:
  def __init__(self, jets):
    self.jets = jets
    self.i = 0

  @classmethod
  def parse(cls, line):
    return Jet([j == '<' and -1 or 1 for j in line.rstrip()])

  def __iter__(self):
    return self

  def __next__(self):
    i = self.i
    self.i += 1
    return self.jets[i % len(self.jets)]
