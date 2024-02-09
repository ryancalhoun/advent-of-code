#pragma once

#include <cstddef>

class LowPoint;

class Risk
{
public:
  Risk();
  Risk(size_t risk);

  Risk operator+(const LowPoint& lowPoint) const;
  operator size_t() const;

protected:
  size_t _risk;
};

