#include "diagnostic.h"
#include <algorithm>
#include <numeric>

Diagnostic::Diagnostic()
  : _degree(0)
{}

void Diagnostic::add(unsigned num, size_t degree)
{
  _report.push_back(num);
  _degree = std::max(_degree, degree);
}

void Diagnostic::add(const std::string& num)
{
  unsigned val = 0;
  for(std::string::const_iterator it = num.begin(); it != num.end(); ++it)
  {
    val *= 2;
    val += *it == '1' ? 1 : 0;
  }
  add(val, num.size());
}

unsigned Diagnostic::powerConsumption() const
{
  std::vector<unsigned> accum(_degree);
  for(std::vector<unsigned>::const_iterator it = _report.begin(); it != _report.end(); ++it)
  {
    for(size_t i = 0; i < _degree; ++i)
    {
      if(*it & 1 << i)
        ++accum[_degree - i - 1];
    }
  }

  unsigned gamma = 0;
  unsigned epsilon = 0;

  for(std::vector<unsigned>::const_iterator it = accum.begin(); it != accum.end(); ++it)
  {
    gamma *= 2;
    epsilon *= 2;
    if(*it > _report.size() / 2)
      ++gamma;
    else
      ++epsilon;
  }

  return gamma * epsilon;
}

namespace
{
  template <typename T>
  void partition(unsigned mask, const T& v, T& one, T& zero)
  {
    one.clear();
    zero.clear();
    for(typename T::const_iterator it = v.begin(); it != v.end(); ++it)
    {
      if(*it & mask)
        one.push_back(*it);
      else
        zero.push_back(*it);
    } 
  }

  template <typename T>
  T filter(unsigned degree, const T& v, bool (*keepOnes)(size_t one, size_t zero))
  {
    T one, zero;
    T result = v;
    for(unsigned mask = 1 << degree-1; result.size() > 1; mask >>= 1)
    {
      ::partition(mask, result, one, zero);
      if(keepOnes(one.size(), zero.size()))
        result = one;
      else
        result = zero;
    }

    return result;
  }

  bool larger(size_t one, size_t zero)
  {
    return one >= zero;
  }

  bool smaller(size_t one, size_t zero)
  {
    return one < zero;
  }
}

unsigned Diagnostic::lifeSupport() const
{
  std::vector<unsigned> o2 = ::filter(_degree, _report, &larger);
  std::vector<unsigned> co2 = ::filter(_degree, _report, &smaller);

  return o2.front() * co2.front();
}

