#include "line.h"

#include <istream>
#include <ostream>
#include <algorithm>

Line::Line()
{}

Line::Line(const Point& first, const Point& last)
  : _first(first)
  , _last(last)
{}

const Point& Line::first() const
{
  return _first;
}

const Point& Line::last() const
{
  return _last;
}

bool Line::vertical() const
{
  return _first.y() == _last.y();
}

bool Line::horizontal() const
{
  return _first.x() == _last.x();
}

namespace
{
  int sgn(int v)
  {
    return (0 < v) - (v < 0);
  }
}

Line::Iterator Line::begin() const
{
  int dx = ::sgn(_last.x() - _first.x());
  int dy = ::sgn(_last.y() - _first.y());

  return Iterator(_first, Point(dx, dy));
}

Line::Iterator Line::end() const
{
  int dx = ::sgn(_last.x() - _first.x());
  int dy = ::sgn(_last.y() - _first.y());

  return Iterator(Point(_last.x() + dx, _last.y() + dy));
}

Line::Iterator::Iterator(const Point& p)
  : _p(p)
{}

Line::Iterator::Iterator(const Point& p, const Point& dp)
  : _p(p)
  , _dp(dp)
{}

const Point& Line::Iterator::operator*() const
{
  return _p;
}

Line::Iterator& Line::Iterator::operator++()
{
  _p += _dp;
  return *this;
}

bool Line::Iterator::operator!=(const Iterator& rhs) const
{
  return _p != *rhs;
}

std::istream& operator>>(std::istream& is, Line& l)
{
  is >> l._first;
  is.ignore(3, '>');
  is >> l._last;
  return is;
}

std::ostream& operator<<(std::ostream& os, const Line& l)
{
  os << l._first << " -> " << l._last;
  return os;
}
