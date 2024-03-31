#pragma once

#include <iosfwd>

class Beacon
{
public:
  Beacon();
  Beacon(int x, int y, int z);

  bool operator<(const Beacon& rhs) const;

  int x() const;
  int y() const;
  int z() const;

  void fw();
  void cw();
  void ccw();
  void shift(int dx, int dy, int dz);

protected:
  friend std::istream& operator>>(std::istream& is, Beacon& b);
  friend std::ostream& operator<<(std::ostream& os, const Beacon& b);

protected:
  int _x;
  int _y;
  int _z;
};
