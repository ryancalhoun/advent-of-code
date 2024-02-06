#include "sequence.h"

Sequence::Sequence()
{}

void Sequence::parse(const std::string& line)
{
  for(size_t begin = 0, end = 0; end != std::string::npos; begin = end + 1)
  {
    end = line.find(',', begin);
    _numbers.push_back(std::stoi(line.substr(begin, end-begin)));
  }
}

Sequence::Iterator Sequence::begin() const
{
  return _numbers.begin();
}

Sequence::Iterator Sequence::end() const
{
  return _numbers.end();
}

Sequence::Iterator::Iterator(std::vector<int>::const_iterator it)
  : _it(it)
{}

int Sequence::Iterator::operator*() const
{
  return *_it;
}

Sequence::Iterator& Sequence::Iterator::operator++()
{
  ++_it;
  return *this;
}

bool Sequence::Iterator::operator!=(const Iterator& rhs) const
{
  return _it != rhs._it;
}

