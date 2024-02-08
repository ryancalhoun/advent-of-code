#include "linear_cost.h"
#include "crab.h"

LinearCost::LinearCost(int p)
  : _p(p)
{}

size_t LinearCost::operator()(size_t total, const Crab& crab) const
{
  return total + crab.distance(_p);
}
