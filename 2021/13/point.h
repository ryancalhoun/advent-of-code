#pragma once

class Point
{
public:
  Point(int x, int y);

  int x() const;
  int y() const;

  Point reflect(char c, int v) const;

  bool operator<(const Point& rhs) const;

protected:
  int _x;
  int _y;
};
