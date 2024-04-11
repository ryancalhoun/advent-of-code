#pragma once

#include <map>

class QuantumDie
{
public:
  QuantumDie();

  using ScoreCount = std::map<int,int>;
  ScoreCount::const_iterator begin() const;
  ScoreCount::const_iterator end() const;

protected:
  ScoreCount _scoreCount;
};
