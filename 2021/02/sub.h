#pragma once

#include <cstddef>

class Sub
{
public:
  Sub();

  void useAiming();

  void up(size_t x);
  void down(size_t x);
  void forward(size_t x);

  size_t position() const;
  size_t depth() const;

protected:
  size_t _position;
  size_t _depth;
  int _aim;

  bool _aiming;
};
