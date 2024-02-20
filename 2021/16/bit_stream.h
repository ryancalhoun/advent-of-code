#pragma once

#include <iosfwd>
#include <vector>

class Packet;

class BitStream
{
public:
  BitStream();

  int get(size_t n);

  void clear();
  size_t tell() const;
  size_t size() const;
  bool operator[](size_t i) const;
  BitStream& operator<<(bool bit);

protected:
  std::vector<bool> _bits; 
  size_t _pos;
};

std::istream& operator>>(std::istream& is, BitStream& p);
std::ostream& operator<<(std::ostream& os, const BitStream& p);
