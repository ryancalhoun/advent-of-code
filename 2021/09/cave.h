#pragma once

#include "low_point.h"

#include <vector>
#include <string>
#include <numeric>

class Cave
{
public:
  Cave();

  void scan(const std::string& line);
  size_t width() const;
  size_t height() const;

  int depth(int x, int y) const;

  class Iterator
  {
  public:
    Iterator(const LowPoint& lowPoint);

    const LowPoint& operator*() const;
    const LowPoint* operator->() const;
    Iterator& operator++();
    bool operator!=(const Iterator& rhs) const;

  protected:
    LowPoint _lowPoint;
  };

  Iterator begin() const;
  Iterator end() const;

  template <typename T>
  size_t assess() const;

protected:
  std::vector<int> _depth;
  size_t _width;
};

template <typename T>
size_t Cave::assess() const
{
  return std::accumulate(begin(), end(), T());
}


