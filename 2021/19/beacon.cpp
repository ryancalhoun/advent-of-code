#include "beacon.h"
#include <istream>
#include <ostream>

Beacon::Beacon()
  : _x(0)
  , _y(0)
  , _z(0)
{}

Beacon::Beacon(int x, int y, int z)
  : _x(x)
  , _y(y)
  , _z(z)
{}

bool Beacon::operator<(const Beacon& rhs) const
{
  if(_x < rhs._x)
  {
    return true;
  }
  else if(_x == rhs._x)
  {
    if(_y < rhs._y)
    {
      return true;
    }
    else if(_y == rhs._y)
    {
      return _z < rhs._z;
    }
  }

  return false;
}

int Beacon::x() const
{
  return _x;
}

int Beacon::y() const
{
  return _y;
}

int Beacon::z() const
{
  return _z;
}

void Beacon::fw()
{
  int w = _z;
  _z = -_y;
  _y = w;
}

void Beacon::cw()
{
  int w = _x;
  _x = -_y;
  _y = w;
}

void Beacon::ccw()
{
  int w = _x;
  _x = _y;
  _y = -w;
}

void Beacon::shift(int dx, int dy, int dz)
{
  _x += dx;
  _y += dy;
  _z += dz;
}

std::istream& operator>>(std::istream& is, Beacon& b)
{
  is >> b._x;
  is.ignore(1);
  is >> b._y;
  is.ignore(1);
  is >> b._z;
  return is;
}

std::ostream& operator<<(std::ostream& os, const Beacon& b)
{
  os << b._x << "," << b._y << "," << b._z;
  return os;
}

