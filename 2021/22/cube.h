#pragma once

#include "range.h"
#include <iosfwd>
#include <functional>

class Cube
{
public:
  Cube();

  operator bool() const;

  template <int min, int max>
  size_t volume() const;

  size_t volume() const;

  const Range& x() const;
  const Range& y() const;
  const Range& z() const;

  using OnSlice = std::function<void(const Cube& c)>;
  bool slice_with(const Cube& c, const OnSlice& on_slice);

protected:
  size_t volume(int min, int max) const;
  void slice(const Range& sliced, const Range& kept, Range Cube::*r, const OnSlice& on_slice);

  friend std::istream& operator>>(std::istream& is, Cube& c);
  friend std::ostream& operator<<(std::ostream& os, const Cube& c);

protected:
  bool _state;

  Range _x;
  Range _y;
  Range _z; 
};

template <int min, int max>
size_t Cube::volume() const
{
  return volume(min, max);
}

