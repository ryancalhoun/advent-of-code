#include "autocomplete.h"
#include <algorithm>

Autocomplete::Autocomplete()
{}

void Autocomplete::onIllegal(char c)
{
}

void Autocomplete::onIncomplete(const std::string& s)
{
  long long score = 0;
  for(char c : s)
  {
    score *= 5;
    switch(c)
    {
    case ')':
      score += 1;
      break;
    case ']':
      score += 2;
      break;
    case '}':
      score += 3;
      break;
    case '>':
      score += 4;
      break;
    }
  }
  _score.push_back(score);
  std::sort(_score.begin(), _score.end());
}

long long Autocomplete::score() const
{
  return _score[_score.size() / 2];
}

