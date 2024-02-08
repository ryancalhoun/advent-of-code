#pragma once

#include <cstddef>

class Crab
{
public:
  Crab(int x);

  size_t distance(int p) const;

protected:
  int _x;
};

