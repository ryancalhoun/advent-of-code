#pragma once

#include <cstddef>

class Amphipod
{
public:
  Amphipod(char type, size_t pos, size_t depth);

  char type() const;
  size_t pos() const;
  size_t depth() const;
  size_t energy() const;
  void move(size_t pos, size_t depth);

protected:
  char _type;
  size_t _pos;
  size_t _depth;
  size_t _energy;
};
