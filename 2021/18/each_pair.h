#pragma once
#include <utility>

template <typename T>
class EachPair
{
public:
  using V = typename T::value_type;

  EachPair(const T& begin, const T& end);

  class Pair
  {
  public:
    Pair(const T& a, const T& end);

    std::pair<const V&,const V&> operator*() const;
    bool operator!=(const Pair& rhs) const;
    Pair& operator++();

  protected:
    T _a;
    T _b;
    T _end;
  };

  Pair begin() const;
  Pair end() const;

protected:
  T _begin;
  T _end;
};

template <typename T>
EachPair<T>::EachPair(const T& begin, const T& end)
  : _begin(begin)
  , _end(end)
{}

template <typename T>
typename EachPair<T>::Pair EachPair<T>::begin() const
{
  return Pair(_begin, _end);
}

template <typename T>
typename EachPair<T>::Pair EachPair<T>::end() const
{
  return Pair(_end, _end);
}

template <typename T>
EachPair<T>::Pair::Pair(const T& a, const T& end)
  : _a(a)
  , _b(a)
  , _end(end)
{
  if(_b != _end)
    ++_b;
}

template <typename T>
std::pair<const typename EachPair<T>::V&, const typename EachPair<T>::V&> EachPair<T>::Pair::operator*() const
{
  return std::pair<const V&,const V&>(*_a, *_b);
}

template <typename T>
bool EachPair<T>::Pair::operator!=(const Pair& rhs) const
{
  return _b != rhs._b;
}

template <typename T>
typename EachPair<T>::Pair& EachPair<T>::Pair::operator++()
{
  if(++_b == _end)
  {
    _b = ++_a;
    ++_b;
  }

  return *this;
}

