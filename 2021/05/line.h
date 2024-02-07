#pragma once

#include "point.h"

class Line
{
public:
  Line();
  Line(const Point& start, const Point& end);

  const Point& first() const;
  const Point& last() const;

  bool vertical() const;
  bool horizontal() const;

  class Iterator
  {
  public:
    Iterator(const Point& p);
    Iterator(const Point& p, const Point& dp);

    const Point& operator*() const;
    Iterator& operator++();
    bool operator!=(const Iterator& rhs) const;

  protected:
    Point _p;
    Point _dp;
  };

  Iterator begin() const;
  Iterator end() const;

protected:
  friend std::istream& operator>>(std::istream& is, Line& l);
  friend std::ostream& operator<<(std::ostream& os, const Line& l);

protected:
  Point _first;
  Point _last;
};

