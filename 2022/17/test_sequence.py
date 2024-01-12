import unittest
from sequence import Sequence

class TestSequence(unittest.TestCase):
  def test_all_same(self):
    s = Sequence()
    s.add(2)
    s.add(2)
    s.add(2)
    s.add(2)
    s.add(2)

    self.assertEqual(s.pattern(), [0, 0])
    self.assertEqual(s[5], 2)
    self.assertEqual(s[6], 2)
    self.assertEqual(s[1000], 2)

  def test_linear(self):
    s = Sequence()
    s.add(2)
    s.add(3)
    s.add(4)
    s.add(5)
    s.add(6)

    self.assertEqual(s.pattern(), [1, 1])
    self.assertEqual(s[5], 7)
    self.assertEqual(s[6], 8)
    self.assertEqual(s[7], 9)
    self.assertEqual(s[1000], 1002)

  def test_non_linear(self):
    s = Sequence()
    s.add(2)
    s.add(3) # 1
    s.add(5) # 2
    s.add(8) # 3
    s.add(9) # 1
    s.add(11) # 2
    s.add(14) # 3

    self.assertEqual(s.pattern(), [1, 2, 3])
    self.assertEqual(s[7], 15)
    self.assertEqual(s[8], 17)
    self.assertEqual(s[9], 20)
    self.assertEqual(s[10], 21)
