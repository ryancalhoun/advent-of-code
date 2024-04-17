#include "quantum_die.h"

QuantumDie::QuantumDie()
{
  for(int i = 1; i <= 3; ++i)
    for(int j = 1; j <= 3; ++j)
      for(int k = 1; k <= 3; ++k)
        ++_count[i+j+k];
}

size_t QuantumDie::count() const
{
  return _count.count();
}

QuantumDie::operator const RollCount& () const
{
  return _count;
}
