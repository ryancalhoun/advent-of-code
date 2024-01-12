class Journey:
  def __init__(self, path = [], val = 0):
    self.path = path
    self.val = val
    self._set = frozenset(path)

  def __repr__(self):
    return f'{self.val}: {self.path}'

  def __int__(self):
    return self.val

  def __len__(self):
    return len(self.path)

  def __lt__(self, other):
    if not other:
      return False
    return self.val < other.val

  def __add__(self, other):
    if isinstance(other, Journey):
      return Journey(self.path + other.path, self.val + other.val)
  
    return Journey(self.path + [other], self.val + int(other))

  def __iter__(self):
    return iter(self.path)

  def __contains__(self, v):
    return v in self.path

  def __and__(self, other):
    return self._set & other._set
