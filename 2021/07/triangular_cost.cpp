#include "triangular_cost.h"
#include "crab.h"

TriangularCost::TriangularCost(int p)
  : _p(p)
{}

size_t TriangularCost::operator()(size_t total, const Crab& crab) const
{
  size_t dist = crab.distance(_p);
  return total + dist * (dist+1) / 2;
}

