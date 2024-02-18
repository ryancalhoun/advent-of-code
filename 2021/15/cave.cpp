#include "cave.h"

#include <string>
#include <istream>
#include <ostream>
#include <unordered_map>
#include <queue>
#include <vector>

template <typename T>
struct Cmp
{
  bool operator()(T a, T b) const
  {
    return a->risk() > b->risk();
  }
};

template<typename T>
using Queue = std::priority_queue<T, std::vector<T>, Cmp<T> >;

Cave::Cave()
  : _width(~0)
  , _up(_map.end())
{}

size_t Cave::shortestPath() const
{
  std::unordered_map<const Position*,size_t> cost;
  cost[&_map.front()] = 0;

  Queue<const Position*> q;
  q.push(&_map.front());

  while(! q.empty())
  {
    auto p = q.top();
    q.pop();

    size_t c = cost[p];

    for(auto n : *p)
    {
      auto cur = cost.find(n);
      if(cur == cost.end() || c + n->risk() < cur->second)
      {
        cost[n] = c + n->risk();
        q.push(n);
      }
    }
  }

  return cost[&_map.back()];
}

void Cave::add(size_t risk)
{
  add(Position(risk));
}

void Cave::add(const Position& p)
{
  Position* left = NULL;

  if(_map.size() % _width != 0)
    left = &_map.back();

  _map.push_back(p);

  if(left)
    left->link(_map.back());
  if(_up != _map.end())
    _up++->link(_map.back());
}

void Cave::endRow()
{
  if(_up == _map.end())
  {
    _up = _map.begin();
    _width = _map.size();
  }
}

