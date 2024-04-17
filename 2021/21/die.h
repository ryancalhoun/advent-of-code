#pragma once

#include "roll_count.h"

class Die
{
public:
  Die();

  RollCount roll(int n);
  int times() const;

protected:
  int _val;
};
