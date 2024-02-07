#include "point.h"
#include <istream>
#include <ostream>

Point::Point()
  : _x(0)
  , _y(0)
{}

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

bool Point::operator<(const Point& rhs) const
{
  if(x() < rhs.x())
    return true;
  if(x() == rhs.x() && y() < rhs.y())
    return true;

  return false;
}

bool Point::operator!=(const Point& rhs) const
{
  return x() != rhs.x() || y() != rhs.y();
}

Point& Point::operator+=(const Point& rhs)
{
  _x += rhs.x();
  _y += rhs.y();
  return *this;
}

std::istream& operator>>(std::istream& is, Point& p)
{
  is >> p._x;
  is.ignore(1, ',');
  is >> p._y;
  return is;
}

std::ostream& operator<<(std::ostream& os, const Point& p)
{
  os << p._x << "," << p._y;
  return os;
}

