#pragma once

#include <iosfwd>

class Enhancement
{
public:
  bool operator[](size_t i) const;

protected:
  friend std::istream& operator>>(std::istream& is, Enhancement& e);

protected:
  bool _lookup[512];
};

