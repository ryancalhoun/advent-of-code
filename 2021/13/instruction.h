#pragma once

#include <iosfwd>

class Instruction
{
public:
  Instruction();

  char axis() const;
  int position() const;

protected:
  friend std::istream& operator>>(std::istream& is, Instruction& inst);

protected:
  char _axis;
  int _position;
};
