#include "fish.h"

#include <numeric>

Fish::Fish(size_t lifetime)
  : _fish(lifetime + 1)
  , _lifetime(lifetime)
{}

void Fish::parse(const std::string& line)
{
  for(size_t begin = 0, end = 0; end != std::string::npos; begin = end + 1)
  {
    end = line.find(',', begin);
    ++_fish[std::stoi(line.substr(begin, end-begin))];
  }
}

void Fish::day()
{
  size_t ready = _fish.front();
  _fish.pop_front();
  _fish.push_back(ready);
  _fish[_lifetime - 2] += ready;
}

size_t Fish::count() const
{
  return std::accumulate(_fish.begin(), _fish.end(), size_t(0));
}

