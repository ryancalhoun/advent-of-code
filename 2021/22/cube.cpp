#include "cube.h"

#include <istream>
#include <ostream>

Cube::Cube()
  : _state(false)
{}

Cube::operator bool() const
{
  return _state;
}

size_t Cube::volume() const
{
  return _x.size() * _y.size() * _z.size();
}

size_t Cube::volume(int min, int max) const
{
  return _x.size(min, max) * _y.size(min, max) * _z.size(min, max);
}

const Range& Cube::x() const
{
  return _x;
}

const Range& Cube::y() const
{
  return _y;
}

const Range& Cube::z() const
{
  return _z;
}

bool Cube::slice_with(const Cube& c, const OnSlice& on_slice)
{
  if(! _x.overlaps(c._x) || ! _y.overlaps(c._y) || ! _z.overlaps(c._z))
    return false;

  slice(Range(c._x.max() + 1, _x.max()), Range(_x.min(), c._x.max()), &Cube::_x, on_slice);
  slice(Range(_x.min(), c._x.min() - 1), Range(c._x.min(), _x.max()), &Cube::_x, on_slice);

  slice(Range(c._y.max() + 1, _y.max()), Range(_y.min(), c._y.max()), &Cube::_y, on_slice);
  slice(Range(_y.min(), c._y.min() - 1), Range(c._y.min(), _y.max()), &Cube::_y, on_slice);

  slice(Range(c._z.max() + 1, _z.max()), Range(_z.min(), c._z.max()), &Cube::_z, on_slice);
  slice(Range(_z.min(), c._z.min() - 1), Range(c._z.min(), _z.max()), &Cube::_z, on_slice);

  return true;
}

void Cube::slice(const Range& sliced, const Range& kept, Range Cube::*r, const OnSlice& on_slice)
{
  if(! sliced)
    return;

  Cube cube = *this;
  cube.*r = sliced;
  on_slice(cube);

  this->*r = kept;
}

std::istream& operator>>(std::istream& is, Cube& c)
{
  std::string s;
  is >> s;
  c._state = s == "on";

  is.ignore(2, '=');

  is >> c._x;

  is.ignore(2, '=');
  is >> c._y;

  is.ignore(2, '=');
  is >> c._z;

  return is;
}

std::ostream& operator<<(std::ostream& os, const Cube& c)
{
  os << (c._state ? "ON" : "OFF") << " x:" << c._x << " y:" << c._y << " z:" << c._z;
  return os;
}

