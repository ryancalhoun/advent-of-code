#include "low_point.h"
#include "cave.h"

#include <set>

LowPoint::LowPoint(const Cave& cave, int x, int y)
  : _cave(cave)
  , _x(x)
  , _y(y)
{}

void LowPoint::findNext()
{
  if(_y == _cave.height())
    return;

  for(++_x; _y < _cave.height(); ++_y, _x = 0)
  {
    for(; _x < _cave.width(); ++_x)
    {
      int d = _cave.depth(_x, _y);
      if(_x > 0 && d >= _cave.depth(_x - 1, _y))
        continue;
      if(_x + 1 < _cave.width() && d >= _cave.depth(_x + 1, _y))
        continue;
      if(_y > 0 && d >= _cave.depth(_x, _y - 1))
        continue;
      if(_y + 1 < _cave.height() && d >= _cave.depth(_x, _y + 1))
        continue;

      return;
    }
  }
}

bool LowPoint::operator!=(const LowPoint& rhs) const
{
  return _x != rhs._x || _y != rhs._y;
}

size_t LowPoint::depth() const
{
  return _cave.depth(_x, _y);
}

namespace
{
  template <typename P, typename F>
  void flood(const Cave& cave, const P& point, F& filled)
  {
    int x = point.first, y = point.second;

    if(x < 0 || x >= cave.width())
      return;
    if(y < 0 || y >= cave.height())
      return;
    if(cave.depth(x, y) == 9)
      return;

    if(filled.find(point) != filled.end())
      return;
    filled.insert(point);

    flood(cave, std::make_pair(x-1, y), filled);
    flood(cave, std::make_pair(x+1, y), filled);
    flood(cave, std::make_pair(x, y-1), filled);
    flood(cave, std::make_pair(x, y+1), filled);
  }
}

size_t LowPoint::basinSize() const
{
  std::set<std::pair<int,int> > filled;
  flood(_cave, std::make_pair(_x, _y), filled);
  return filled.size();
}

