#include "crab.h"

#include <cstdlib>

Crab::Crab(int x)
  : _x(x)
{}

size_t Crab::distance(int p) const
{
  return ::abs(_x - p);
}
