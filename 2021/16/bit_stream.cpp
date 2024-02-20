#include "bit_stream.h"
#include <istream>
#include <ostream>
#include <string>

BitStream::BitStream()
  : _pos(0)
{}

int BitStream::get(size_t n)
{
  int x = 0;
  for(size_t i = 0; _pos < size() && i < n; ++i)
  {
    x <<= 1;
    x |= _bits[_pos++];
  }
  return x;
}

void BitStream::clear()
{
  _bits.clear();
  _pos = 0;
}

size_t BitStream::tell() const
{
  return _pos;
}

size_t BitStream::size() const
{
  return _bits.size();
}

bool BitStream::operator[](size_t i) const
{
  return _bits[i];
}

BitStream& BitStream::operator<<(bool bit)
{
  _bits.push_back(bit);
  return *this;
}

std::istream& operator>>(std::istream& is, BitStream& b)
{
  std::string line;
  std::getline(is, line);

  b.clear();

  for(char c : line)
  {
    int x = c >= 'A' ? c - 'A' + 10 : c - '0';
    for(int mask = 1<<3; mask > 0; mask >>= 1)
      b << (x & mask);
  }

  return is;
}

std::ostream& operator<<(std::ostream& os, const BitStream& b)
{
  for(size_t i = 0; i < b.size(); ++i)
    os << (int)b[i];
  return os;
}

