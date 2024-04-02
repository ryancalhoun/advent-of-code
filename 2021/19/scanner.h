#pragma once
#include "beacon.h"
#include <iosfwd>
#include <vector>

class Scanner
{
public:
  Scanner();

  int id() const;

  int x() const;
  int y() const;
  int z() const;

  bool alignWith(const Scanner& s);
  bool nextTurn();

  void fw();
  void cw();
  void ccw();

  std::vector<Beacon>::const_iterator begin() const;
  std::vector<Beacon>::const_iterator end() const;

protected:
  bool moveTo(int x, int y, int z);
  friend std::istream& operator>>(std::istream& is, Scanner& s);
  friend std::ostream& operator<<(std::ostream& os, const Scanner& s);

protected:
  int _id;

  int _x;
  int _y;
  int _z;

  int _i;
  int _j;

  std::vector<Beacon> _beacons;
};

