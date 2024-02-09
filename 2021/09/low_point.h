#pragma once

#include <cstddef>

class Cave;

class LowPoint
{
public:
  LowPoint(const Cave& cave, int x, int y);

  void findNext();
  bool operator!=(const LowPoint& rhs) const;

  size_t depth() const;
  size_t basinSize() const;

protected:
  const Cave& _cave;
  int _x;
  int _y;
};
