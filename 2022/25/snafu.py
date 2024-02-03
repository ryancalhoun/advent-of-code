class Snafu:
  DIGITS = {
    '2' :  2,
    '1' :  1,
    '0' :  0,
    '-' : -1,
    '=' : -2,
  }

  def __init__(self, val = 0):
    if type(val) == str:
      self.val = 0
      for char in val.strip():
        self <<= Snafu.DIGITS[char]
    else:
      self.val = val

  def __eq__(self, other):
    if type(other) == int:
      return self.val == other
    if type(other) == str:
      return str(self) == other

  def __int__(self):
    return self.val

  def __str__(self):
    v = self.val
    s = []
    while v != 0:
      r = v % 5
      if r == 4:
        s.insert(0, '-')
        v += 1
      elif r == 3:
        s.insert(0, '=')
        v += 2
      else:
        s.insert(0, str(r))
      v //= 5
    return ''.join(s)


  def __lshift__(self, digit):
    self.val *= 5
    self.val += digit
    return self
