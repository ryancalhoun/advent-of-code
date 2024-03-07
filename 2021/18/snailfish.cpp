#include "snailfish.h"
#include <string>
#include <stack>
#include <istream>
#include <ostream>

Snailfish::Snailfish()
{}

Snailfish Snailfish::operator+(const Snailfish& rhs) const
{
  if(_number.empty())
    return rhs;

  Snailfish sum = *this;
  ++sum._number.front().push;

  for(auto n : rhs._number)
    sum._number.push_back({n.value, n.push, n.pop});
  ++sum._number.back().pop;

  while(sum.reduce());

  return sum;
}

int Snailfish::magnitude() const
{
  std::stack<int> s;
  for(auto n : _number)
  {
    s.push(n.value);

    for(int i = 0; i < n.pop; ++i)
    {
      int b = s.top();
      s.pop();

      int a = s.top();
      s.pop();
  
      s.push(a * 3 + b * 2);
    }
  }

  return s.top();
}

bool Snailfish::reduce()
{
  return explode() || split(); 
}

bool Snailfish::explode()
{
  if(_number.size() < 2)
    return false;

  auto a = _number.begin();
  auto b = a;
  int depth = 0;

  for(++b; b != _number.end(); ++a, ++b)
  {
    depth += a->push;
    if(depth > 4 && a->pop == 0 && b->push == 0)
    {
      auto c = a;
      if(--c != _number.end())
        c->value += a->value;

      c = b;
      if(++c != _number.end())
        c->value += b->value;

      --a->push;
      a->pop = b->pop - 1;
      a->value = 0;

      _number.erase(b);

      return true;
    }
    depth -= a->pop;
  }

  return false;
}

bool Snailfish::split()
{
  for(auto it = _number.begin(); it != _number.end(); ++it)
  {
    if(it->value > 9)
    {
      auto a = _number.insert(it, {it->value / 2, it->push+1, 0});
      it->value -= a->value;
      it->push = 0;
      ++it->pop;

      return true;
    }
  }

  return false;
}

std::istream& operator>>(std::istream& is, Snailfish& sf)
{
  sf._number.clear();

  std::string line;
  std::getline(is, line);

  int push = 0;

  for(char c : line)
  {
    if(c == '[')
    {
      ++push;
    }
    else if(c == ']')
    {
      ++sf._number.back().pop;
    }
    else if(c != ',')
    {
      sf._number.push_back({c - '0', push, 0});
      push = 0;
    }
  }

  return is;
}

std::ostream& operator<<(std::ostream& os, const Snailfish& sf)
{
  for(auto n : sf._number)
  {
    for(int i = 0; i < n.push; ++i)
      os << '[';
    os << n.value;
    for(int i = 0; i < n.pop; ++i)
      os << ']';

    os << ',';
  }

  return os;
}
