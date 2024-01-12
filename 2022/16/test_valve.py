import unittest
from valve import Valve

class TestValve(unittest.TestCase):
  def test_sub(self):
    v = Valve('AA', 0, [])
    self.assertEqual(v - 'AA', 0)

    v.visit('BB', 5)
    self.assertEqual(v - 'BB', 5)

  def test_mul(self):
    v = Valve('AA', 5, [])
    self.assertEqual(int(v * 3), 15)
