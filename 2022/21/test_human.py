import unittest
from human import Unknown

class TestUnknown(unittest.TestCase):
  def test_add(self):
    x = Unknown()
    self.assertEqual(x + 7 == 10, 3)

  def test_sub(self):
    x = Unknown()
    self.assertEqual(x - 7 == 3, 10)

  def test_rsub(self):
    x = Unknown()
    self.assertEqual(10 - x == 3, 7)

  def test_mul(self):
    x = Unknown()
    self.assertEqual(5 * x == 10, 2)

  def test_div(self):
    x = Unknown()
    self.assertEqual(x // 2 == 5, 10)

  def test_expression(self):
    x = Unknown()
    self.assertEqual(((2 * (x + 3)) + 4) // 2 == 12, 7)
