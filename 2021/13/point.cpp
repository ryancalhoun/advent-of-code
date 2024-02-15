#include "point.h"

Point::Point(int x, int y)
  : _x(x)
  , _y(y)
{}

int Point::x() const
{
  return _x;
}

int Point::y() const
{
  return _y;
}

Point Point::reflect(char c, int v) const
{
  if(c == 'x')
  {
    if(_x < v)
      return *this;
    return Point(2*v - _x, _y);
  }

  if(c == 'y')
  {
    if(_y < v)
      return *this;
    return Point(_x, 2*v - _y);
  }

  throw;
}

bool Point::operator<(const Point& rhs) const
{
  if(_x < rhs._x)
    return true;
  if(_x == rhs._x && _y < rhs._y)
    return true;

  return false;
}


