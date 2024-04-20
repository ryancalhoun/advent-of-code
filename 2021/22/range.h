#pragma once

#include <iosfwd>

class Range
{
public:
  Range();
  Range(int min, int max);

  operator bool () const;

  int min() const;
  int max() const;

  size_t size() const;
  size_t size(int min, int max) const;

  bool overlaps(const Range& r) const;

protected:
  friend std::istream& operator>>(std::istream& is, Range& r);
  friend std::ostream& operator<<(std::ostream& os, const Range& r);

protected:
  int _min;
  int _max;
};

