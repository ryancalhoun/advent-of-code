#include "cave.h"

Cave::Cave()
{}

void Cave::scan(const std::string& line)
{
  for(char c : line)
    _depth.push_back(c - '0');

  _width = line.size();
}

size_t Cave::width() const
{
  return _width;
}

size_t Cave::height() const
{
  return _depth.size() / _width;
}

int Cave::depth(int x, int y) const
{
  return _depth[x + y*_width];
}

Cave::Iterator::Iterator(const LowPoint& lowPoint)
  : _lowPoint(lowPoint)
{
  _lowPoint.findNext();
}

const LowPoint& Cave::Iterator::operator*() const
{
  return _lowPoint;
}

const LowPoint* Cave::Iterator::operator->() const
{
  return &_lowPoint;
}

Cave::Iterator& Cave::Iterator::operator++()
{
  _lowPoint.findNext();
  return *this;
}

bool Cave::Iterator::operator!=(const Iterator& rhs) const
{
  return _lowPoint != rhs._lowPoint;
}

Cave::Iterator Cave::begin() const
{
  return LowPoint(*this, -1, 0);
}

Cave::Iterator Cave::end() const
{
  return LowPoint(*this, 0, height());
}

