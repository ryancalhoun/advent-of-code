import sys
import os
import directory
import nested
import terminal

root = terminal.parse_from(sys.stdin)
sizes = directory.directory_sizes(root)

if os.environ.get('PART') == '1':
  print(sum([s for s in nested.all_values(sizes) if s <= 100000]))
else:
  print(min([s for s in nested.all_values(sizes) if 70000000 - sizes[0] + s >= 30000000]))

