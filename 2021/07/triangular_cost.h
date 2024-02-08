#pragma once

#include <cstddef>

class Crab;

class TriangularCost
{
public:
  TriangularCost(int p);
  size_t operator()(size_t total, const Crab& crab) const;

protected:
  int _p;
};
