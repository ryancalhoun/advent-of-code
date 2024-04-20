#include "range.h"
#include <istream>
#include <ostream>

Range::Range()
  : _min(0)
  , _max(0)
{}

Range::Range(int min, int max)
  : _min(min)
  , _max(max)
{}

Range::operator bool() const
{
  return _min <= _max;
}

int Range::min() const
{
  return _min;
}

int Range::max() const
{
  return _max;
}

size_t Range::size() const
{
  return _max - _min + 1;
}

size_t Range::size(int min, int max) const
{
  if(_min > max || _max < min)
    return 0;
  return size();
}

bool Range::overlaps(const Range& r) const
{
  return _min <= r._max && _max >= r._min;
}

std::istream& operator>>(std::istream& is, Range& r)
{
  is >> r._min;
  is.ignore(2);
  is >> r._max;

  return is;
}

std::ostream& operator<<(std::ostream& os, const Range& r)
{
  os << "[" << r._min << "," << r._max << "]";
  return os;
}
