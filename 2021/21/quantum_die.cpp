#include "quantum_die.h"

QuantumDie::QuantumDie()
{
  for(int i = 1; i <= 3; ++i)
    for(int j = 1; j <= 3; ++j)
      for(int k = 1; k <= 3; ++k)
        ++_scoreCount[i*j*k];
}

QuantumDie::ScoreCount::const_iterator QuantumDie::begin() const
{
  return _scoreCount.begin();
}

QuantumDie::ScoreCount::const_iterator QuantumDie::end() const
{
  return _scoreCount.end();
}
