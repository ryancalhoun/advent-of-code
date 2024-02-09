#pragma once

#include <deque>

class LowPoint;

class BasinSize
{
public:
  BasinSize();
  BasinSize(const std::deque<size_t>& basins);

  BasinSize operator+(const LowPoint& lowPoint) const;
  operator size_t() const;

protected:
  std::deque<size_t> _basins;
};

