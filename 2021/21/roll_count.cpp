#include "roll_count.h"

RollCount::RollCount()
{}

RollCount::RollCount(int roll)
  : _count({{ roll, 1 }})
{}

int& RollCount::operator[](int roll)
{
  return _count[roll];
}

size_t RollCount::count() const
{
  size_t c(0);
  for(const auto [roll, count] : _count)
    c += count;

  return c;
}

std::map<int,int>::const_iterator RollCount::begin() const
{
  return _count.begin();
}

std::map<int,int>::const_iterator RollCount::end() const
{
  return _count.end();
}

