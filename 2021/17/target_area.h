#pragma once

#include <iosfwd>

class TargetArea
{
public:
  TargetArea();

  int xmax() const;
  int ymin() const;
  bool in(int x, int y) const;

protected:
  friend std::istream& operator>>(std::istream& is, TargetArea& area);

protected:
  int _xmin;
  int _xmax;
  int _ymin;
  int _ymax;
};
