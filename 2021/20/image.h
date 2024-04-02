#pragma once

#include <iosfwd>
#include <vector>

class Enhancement;

class Image
{
public:
  Image();
  Image(size_t size, bool inv);

  bool value(size_t i, size_t j) const;

  size_t count_on() const;
  Image operator&(const Enhancement& e) const;

protected:
  friend std::istream& operator>>(std::istream& is, Image& img);
  friend std::ostream& operator<<(std::ostream& os, const Image& img);

  std::vector<bool> _pixels;
  size_t _size;
  bool _inv;
};
