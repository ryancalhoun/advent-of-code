#include "basin_size.h"
#include "low_point.h"

#include <algorithm>
#include <numeric>
#include <functional>

BasinSize::BasinSize()
{}

BasinSize::BasinSize(const std::deque<size_t>& basins)
  : _basins(basins)
{}

BasinSize BasinSize::operator+(const LowPoint& lowPoint) const
{
  std::deque<size_t> basins = _basins;

  basins.push_back(lowPoint.basinSize());
  std::sort(basins.begin(), basins.end());

  if(basins.size() > 3)
    basins.pop_front();

  return basins;
}

BasinSize::operator size_t() const
{
  return std::accumulate(_basins.begin(), _basins.end(), size_t(1), std::multiplies<size_t>());
}

