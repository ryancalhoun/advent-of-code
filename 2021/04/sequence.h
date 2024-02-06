#pragma once

#include <string>
#include <vector>

class Sequence
{
public:
  Sequence();

  void parse(const std::string& line);

public:
  class Iterator
  {
  public:
    Iterator(std::vector<int>::const_iterator it);

    int operator*() const;
    Iterator& operator++();
    bool operator!=(const Iterator& rhs) const;

  protected:
    std::vector<int>::const_iterator _it;
  };

  Iterator begin() const;
  Iterator end() const;

protected:
  std::vector<int> _numbers;
};

