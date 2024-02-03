import unittest
from snafu import Snafu

class TestSnafu(unittest.TestCase):
  def testForward(self):
    self.assertEqual(Snafu('1'), 1)
    self.assertEqual(Snafu('2'), 2)
    self.assertEqual(Snafu('1='), 3)
    self.assertEqual(Snafu('1-'), 4)
    self.assertEqual(Snafu('10'), 5)
    self.assertEqual(Snafu('11'), 6)
    self.assertEqual(Snafu('12'), 7)
    self.assertEqual(Snafu('2='), 8)
    self.assertEqual(Snafu('2-'), 9)
    self.assertEqual(Snafu('20'), 10)
    self.assertEqual(Snafu('1=0'), 15)
    self.assertEqual(Snafu('1-0'), 20)
    self.assertEqual(Snafu('1=11-2'), 2022)
    self.assertEqual(Snafu('1-0---0'), 12345)
    self.assertEqual(Snafu('1121-1110-1=0'), 314159265)

  def testReverse(self):
    self.assertEqual(Snafu(1), '1')
    self.assertEqual(Snafu(2), '2')
    self.assertEqual(Snafu(3), '1=')
    self.assertEqual(Snafu(4), '1-')
    self.assertEqual(Snafu(5), '10')
    self.assertEqual(Snafu(6), '11')
    self.assertEqual(Snafu(7), '12')
    self.assertEqual(Snafu(8), '2=')
    self.assertEqual(Snafu(9), '2-')
    self.assertEqual(Snafu(10), '20')
    self.assertEqual(Snafu(15), '1=0')
    self.assertEqual(Snafu(20), '1-0')
    self.assertEqual(Snafu(2022), '1=11-2')
    self.assertEqual(Snafu(12345), '1-0---0')
    self.assertEqual(Snafu(314159265), '1121-1110-1=0')

