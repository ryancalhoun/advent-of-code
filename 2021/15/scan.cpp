#include "scan.h"
#include "cave.h"

#include <istream>

Scan::Scan()
  : _repeat(1)
{}

void Scan::repeat(size_t n)
{
  _repeat = n;
}

size_t Scan::width() const
{
  return _scan.empty() ? 0 : _scan.front().size();
}

size_t Scan::height() const
{
  return _scan.size();
}

size_t Scan::repeat() const
{
  return _repeat;
}

const std::vector<std::string>& Scan::data() const
{
  return _scan;
}

Scan::Iterator Scan::begin() const
{
  return Iterator(*this, 0);
}

Scan::Iterator Scan::end() const
{
  return Iterator(*this, _scan.size() * _repeat);
}

Scan::Iterator::Iterator(const Scan& s, size_t i)
  : _s(s)
  , _i(i)
{
  if(_i == 0)
    update();
}

bool Scan::Iterator::operator!=(const Iterator& rhs) const
{
  return _i != rhs._i;
}

Scan::Iterator& Scan::Iterator::operator++()
{
  ++_i;
  update();
  return *this;
}

const std::vector<size_t>& Scan::Iterator::operator*() const
{
  return _row;
}

void Scan::Iterator::update()
{
  _row.clear();

  const std::string& data = _s.data()[_i % _s.width()];

  for(size_t j = 0; j < _s.repeat(); ++j)
    for(char c : data)
      _row.push_back((c - '1' + j + (_i / _s.height())) % 9 + 1);
}

std::istream& operator>>(std::istream& is, Scan& s)
{
  std::string line;
  while(std::getline(is, line))
    s._scan.push_back(line);

  return is;
}

