#include "risk.h"
#include "low_point.h"

Risk::Risk()
  : _risk(0)
{}

Risk::Risk(size_t risk)
  : _risk(risk)
{}

Risk Risk::operator+(const LowPoint& lowPoint) const
{
  return _risk + 1 + lowPoint.depth();
}

Risk::operator size_t() const
{
  return _risk;
}

