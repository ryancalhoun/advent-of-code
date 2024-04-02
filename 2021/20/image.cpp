#include "image.h"
#include "enhancement.h"
#include <istream>
#include <numeric>

Image::Image()
  : _size(0)
  , _inv(false)
{}

Image::Image(size_t size, bool inv)
  : _pixels(size * size)
  , _size(size)
  , _inv(inv)
{}

bool Image::value(size_t i, size_t j) const
{
  if(i < _size && j < _size)
    return _inv ^ _pixels[i * _size + j];
  return _inv;
}

size_t Image::count_on() const
{
  return std::accumulate(_pixels.begin(), _pixels.end(), 0, [](int sum, bool val) { return sum + (val ? 1 : 0); });
}

Image Image::operator&(const Enhancement& e) const
{
  Image out(_size + 2, e[0] ? !_inv : false);

  for(size_t p = 0; p < out._pixels.size(); ++p)
  {
    size_t i = p / out._size - 1;
    size_t j = p % out._size - 1;

    size_t x = 0;
    auto m = [&](bool val) {
      x <<= 1;
      x |= val;
    };

    m(value(i-1, j-1));
    m(value(i-1, j));
    m(value(i-1, j+1));

    m(value(i, j-1));
    m(value(i, j));
    m(value(i, j+1));

    m(value(i+1, j-1));
    m(value(i+1, j));
    m(value(i+1, j+1));

    out._pixels[p] = out._inv ^ e[x];
  }

  return out;
}

std::istream& operator>>(std::istream& is, Image& img)
{
  char c;
  while(is >> c)
  {
    img._pixels.push_back(c == '#');

    if(img._size * img._size < img._pixels.size())
      ++img._size;
  }

  return is;
}

std::ostream& operator<<(std::ostream& os, const Image& img)
{
  for(size_t i = 0; i < img._size; ++i)
  {
    for(size_t j = 0; j < img._size; ++j)
    {
      if(img.value(i, j))
        os << '#';
      else
        os << '.';
    }
    os << std::endl;
  }

  return os;
}
