#pragma once
#include "beacon.h"
#include <iosfwd>
#include <vector>
#include <set>

class Scanner
{
public:
  Scanner();

  int id() const;

  bool alignWith(const Scanner& s);
  bool nextTurn();
  void fix();

  void fw();
  void cw();
  void ccw();

  std::set<Beacon>::const_iterator begin() const;
  std::set<Beacon>::const_iterator end() const;

protected:
  friend std::istream& operator>>(std::istream& is, Scanner& s);
  friend std::ostream& operator<<(std::ostream& os, const Scanner& s);

protected:
  int _id;
  int _i;
  int _j;
  std::vector<Beacon> _beacons;
  std::set<Beacon> _fixed;
};

