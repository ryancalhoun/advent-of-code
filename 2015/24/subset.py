class Subset:
  def __init__(self, arr):
    self.data = [[]]
    self.arr = arr

  def sum_to(self, n):
    if not self.arr or not n:
      return False

    self.data = [[False for i in range(n+1)] for j in range(len(self.arr))]

    for i in range(len(self.arr)):
      self.data[i][0] = True

    if (self.arr[0] <= n):
      self.data[0][self.arr[0]] = True

    for i in range(1, len(self.arr)):
      for j in range(0, n + 1):
        if self.arr[i] <= j:
          self.data[i][j] = (self.data[i-1][j] or self.data[i-1][j-self.arr[i]])
        else:
          self.data[i][j] = self.data[i - 1][j]

    if not self.data[len(self.arr)-1][n]:
      return False

    return True

  def each(self, n):

    def each_r(i, n, p):
      if i == 0:
        if n != 0 and self.data[0][n]:
          p.append(self.arr[i])
          yield p
          p.clear()
          return
        if n == 0:
          yield p
          p.clear()
          return

      if self.data[i-1][n]:
        b = []
        b.extend(p)
        yield from each_r(i-1, n, b)

      if n >= self.arr[i-1] and self.data[i-1][n-self.arr[i]]:
        p.append(self.arr[i])
        yield from each_r(i-1, n-self.arr[i], p)


    yield from each_r(len(self.arr)-1, n, [])


