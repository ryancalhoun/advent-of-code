class Sequence:
  def __init__(self, minimum=1):
    self.values = []
    self.dx = []
    self._start = None
    self._length = 0
    self._min = minimum

  def __getitem__(self, i):
    if i < len(self.values):
      return self.values[i]

    if self._length:
      return self.extrapolate(i)

  def add(self, x):
    if len(self.dx) == 0:
      self.dx.append(x)
    else:
      self.dx.append(x - self.values[-1])
    self.values.append(x)
    if self._length == 0:
      self.find_sequence()

  def pattern(self):
    return self.dx[len(self.dx) - self._length:]

  def find_sequence(self):
    n = int(len(self.dx) / 2)
    while n > self._min:
      if self.test_sequence(n):
        self._start = len(self.dx) - 2*n
        self._length = n
        return True
      n -= 1

    return False

  def test_sequence(self, n):
    m = len(self.dx)
    for i in range(n):
      if self.dx[m - i - 1] != self.dx[m - n - i - 1]:
        return False
    return True

  def extrapolate(self, i):
    i -= self._start
    n = int(i / self._length)
    m = i % self._length
    p = self.pattern()
    return self.values[self._start-1] + n * sum(p) + sum(p[0:m+1])


