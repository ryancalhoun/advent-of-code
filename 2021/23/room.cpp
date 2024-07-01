#include "room.h"

Room::Room()
{}

Room::Room(char type, size_t pos)
  : _type(type)
  , _pos(pos)
{}

char Room::type() const
{
  return _type;
}

size_t Room::pos() const
{
  return _pos;
}

