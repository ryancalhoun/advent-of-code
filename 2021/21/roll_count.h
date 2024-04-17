#pragma once

#include <map>

class RollCount
{
public:
  RollCount();
  RollCount(int roll);

  int& operator[](int roll);
  size_t count() const;

  std::map<int,int>::const_iterator begin() const;
  std::map<int,int>::const_iterator end() const;

protected:
  std::map<int,int> _count;
};
