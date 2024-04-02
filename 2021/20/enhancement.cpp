#include "enhancement.h"
#include <istream>

bool Enhancement::operator[](size_t i) const
{
  return _lookup[i];
}

std::istream& operator>>(std::istream& is, Enhancement& e)
{
  char c;
  for(int i = 0; i < 512; ++i)
  {
    is >> c;
    e._lookup[i] = c == '#';
  }

  return is;
}

