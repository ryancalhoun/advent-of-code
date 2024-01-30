class Unknown:
  def __init__(self):
    self.operations = []

  def __add__(self, other):
    self.operations.insert(0, lambda n: n - other)
    return self

  def __radd__(self, other):
    return self.__add__(other)

  def __sub__(self, other):
    self.operations.insert(0, lambda n: n + other)
    return self

  def __rsub__(self, other):
    self.operations.insert(0, lambda n: other - n)
    return self

  def __mul__(self, other):
    self.operations.insert(0, lambda n: n // other)
    return self

  def __rmul__(self, other):
    return self.__mul__(other)

  def __floordiv__(self, other):
    self.operations.insert(0, lambda n: n * other)
    return self

  def __eq__(self, other):
    for op in self.operations:
      other = op(other)
    return other
