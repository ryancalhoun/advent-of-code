#include "instruction.h"

#include <istream>
#include <string>

Instruction::Instruction()
  : _axis(0)
  , _position(0)
{}

char Instruction::axis() const
{
  return _axis;
}

int Instruction::position() const 
{
  return _position;
}

std::istream& operator>>(std::istream& is, Instruction& inst)
{
  is.ignore(5, ' ');
  is.ignore(6, ' ');
  is >> inst._axis;
  is.ignore(1, '=');
  is >> inst._position;

  return is; 
}

