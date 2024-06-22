import re
import itertools

class Shop:
  def __new__(cls):
    cls.shop = {}

    with open('data.txt') as f:
      for line in f:
        m = re.search(r'(\w+):', line)
        if m:
          last = cls.shop[m.group(1)] = []
        m = re.search(r'^\w+ (?:\+\d)?\w*(.*)', line)
        if m:
          last.append([int(i) for i in m.group(1).split()])
    return super().__new__(cls)

  def arrangements(self):
    s = type(self).shop

    def enum(key, r):
      return itertools.chain.from_iterable(itertools.combinations(s[key], i) for i in r)

    def add(*types):
      s = [0, 0, 0]
      for items in types:
        for item in items:
          s = [sum(e) for e in zip(item, s)]
      return s

    for w in enum('Weapons', range(1, 2)):
      for a in enum('Armor', range(0, 2)):
        for r in enum('Rings', range(0, 3)):
          yield add(w, a, r)

