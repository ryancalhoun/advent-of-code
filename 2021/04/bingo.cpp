#include "bingo.h"

#include <string>
#include <algorithm>
#include <iostream>

size_t Bingo::size = 5;

Bingo::Bingo()
  : _tally(size+size)
  , _last(0)
{}

void Bingo::parse(const std::string& line)
{
  for(size_t begin = 0, end = 0; end != std::string::npos; begin = end + 1)
  {
    while(line[begin] == ' ')
      ++begin;
    end = line.find(' ', begin);
    _numbers.push_back(std::stoi(line.substr(begin, end-begin)));
  }
}

bool Bingo::call(int number)
{
  _last = number;
  std::vector<int>::const_iterator it = std::find(_numbers.begin(), _numbers.end(), number);
  if(it != _numbers.end())
  {
    size_t i = it - _numbers.begin();
    _called.insert(i);

    size_t row = i / size;
    size_t col = i % size;

    if(++_tally[row] == size || ++_tally[col + size] == size)
      return true;
  }

  return false;
}

int Bingo::score() const
{
  int sum = 0;
  for(size_t i = 0; i < _numbers.size(); ++i)
  {
    if(_called.find(i) != _called.end())
      continue;
    sum += _numbers[i];
  }

  return sum * _last;
}

