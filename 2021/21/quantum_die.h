#pragma once

#include "roll_count.h"

class QuantumDie
{
public:
  QuantumDie();

  size_t count() const;

  operator const RollCount&() const;

protected:
  RollCount _count;
};
