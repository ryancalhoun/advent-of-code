import sys

from snafu import Snafu

total = 0
for line in sys.stdin:
  s = Snafu(line)
  total += int(s)

print(str(Snafu(total)))

