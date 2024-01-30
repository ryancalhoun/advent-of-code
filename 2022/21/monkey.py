class Job:
  def __init__(self, exp, tree):
    self.tree = tree
    exp = exp.split(' ')
    if len(exp) == 1:
      self.value = int(exp[0])
    else:
      self.left = exp[0]
      self.right = exp[2]
      if exp[1] == '+':
        self.oper = lambda a,b : a + b
      if exp[1] == '-':
        self.oper = lambda a,b : a - b
      if exp[1] == '*':
        self.oper = lambda a,b : a * b
      if exp[1] == '/':
        self.oper = lambda a,b : a // b

  def evaluate(self):
    if hasattr(self, 'value'):
      return self.value

    left = self.tree[self.left]
    right = self.tree[self.right]

    return self.oper(left.evaluate(), right.evaluate())

class Tree:
  def __init__(self):
    self.jobs = {}

  def parse(self, line):
    name, exp = line.split(':')
    self.jobs[name.strip()] = Job(exp.strip(), self)

  def __getitem__(self, key):
    return self.jobs[key]
