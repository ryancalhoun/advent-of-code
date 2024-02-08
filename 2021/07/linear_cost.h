#pragma once

#include <cstddef>

class Crab;

class LinearCost
{
public:
  LinearCost(int p);
  size_t operator()(size_t total, const Crab& crab) const;

protected:
  int _p;
};
