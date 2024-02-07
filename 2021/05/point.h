#pragma once

#include <string>
#include <iosfwd>

class Point
{
public:
  Point();
  Point(int x, int y);

  int x() const;
  int y() const;

  bool operator<(const Point& rhs) const;
  bool operator!=(const Point& rhs) const;

  Point& operator+=(const Point& rhs);

protected:
  friend std::istream& operator>>(std::istream& is, Point& p);
  friend std::ostream& operator<<(std::ostream& os, const Point& p);

protected:
  int _x;
  int _y;
};
