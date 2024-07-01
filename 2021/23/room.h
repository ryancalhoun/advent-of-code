#pragma once

#include <cstddef>

class Room
{
public:
  Room();
  Room(char type, size_t pos);

  char type() const;
  size_t pos() const;

protected:
  char _type;
  size_t _pos;
};
