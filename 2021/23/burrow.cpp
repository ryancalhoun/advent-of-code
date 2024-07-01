#include "burrow.h"
#include <algorithm>
#include <istream>
#include <string>

Burrow::Burrow()
  : _min(~0ul)
  , _max(0)
  , _hallway(0)
{}


#include <iostream>
size_t Burrow::sort()
{
  return sort(_pods, ~0ul);
}

std::ostream& operator<<(std::ostream& os, const std::deque<Amphipod>& pods)
{
  std::vector<std::string> burrow = { "#...........#", "###.#.#.#.###", "  #.#.#.#.#  ", "  #########  " };

  for(const Amphipod& pod : pods)
    burrow[pod.depth() - 1][pod.pos()] = pod.type();

  for(const std::string& s : burrow)
    os << s << std::endl;

  return os;
}

size_t Burrow::sort(const Pods& pods, size_t min_energy) const
{
  size_t e = energy(pods);

  if(e > min_energy)
    return min_energy;

  if(all_sorted(pods))
    return e;

  for(Pods::const_iterator it = pods.begin(); it != pods.end(); ++it)
  {
    if(! should_move(pods.begin(), pods.end(), it))
      continue;

    std::set<size_t> positions;
    possible(pods.begin(), pods.end(), it, positions);

    size_t offset = std::distance(pods.begin(), it);

    for(size_t p : positions)
    {
      Pods n = pods;
      Pods::iterator j = n.begin() + offset;

      size_t depth;
      if(j->energy() == 0)
      {
        depth = _hallway;
      }
      else
      {
        if(_rooms[j->type() - 'A'] == bud(pods.begin(), pods.end(), offset).pos())
          depth = _hallway + 1;
        else
          depth = _hallway + 2;
      }

      j->move(p, depth);

      size_t e = sort(n, min_energy);

      if(e < min_energy)
        min_energy = e;
    }
  }

  return min_energy;
}

bool Burrow::all_sorted(const Pods& pods) const
{
  for(const Amphipod& p : pods)
  {
    if(_rooms[p.type() - 'A'] != p.pos())
      return false;
  }

  return true;
}

size_t Burrow::energy(const Pods& pods) const
{
  size_t e = 0;
  for(const Amphipod& p : pods)
    e += p.energy();
  return e;
}

void Burrow::possible(Pods::const_iterator begin, Pods::const_iterator end, Pods::const_iterator it, std::set<size_t>& positions) const
{
  std::set<size_t> hallway;
  for(size_t s = _min; s <= _max; ++s)
      hallway.insert(s);

  for(Pods::const_iterator j = begin; j != end; ++j)
  {
    if(j->depth() == _hallway)
      hallway.erase(j->pos());
  }
  
  if(it->energy() == 0)
  {
    for(size_t p = it->pos() - 1; p >= _min; --p)
    {
      if(hallway.find(p) == hallway.end())
        break;
      if(std::find(_rooms.begin(), _rooms.end(), p) != _rooms.end())
        continue;
      positions.insert(p);
    }
    for(size_t p = it->pos() + 1; p <= _max; ++p)
    {
      if(hallway.find(p) == hallway.end())
        break;
      if(std::find(_rooms.begin(), _rooms.end(), p) != _rooms.end())
        continue;
      positions.insert(p);
    }
  }
  else
  {
    size_t target = _rooms[it->type() - 'A'];
    if(target < it->pos())
    {
      bool ac = true;
      for(size_t p = target; p < it->pos(); ++p)
        if(hallway.find(p) == hallway.end())
        {
          ac = false;
          break;
        }
      if(ac)
        positions.insert(target);
    }
    else
    {
      bool ac = true;
      for(size_t p = it->pos() + 1; p <= target; ++p)
        if(hallway.find(p) == hallway.end())
        {
          ac = false;
          break;
        }
      if(ac)
        positions.insert(target);
    }
  }
}

bool Burrow::should_move(Pods::const_iterator begin, Pods::const_iterator end, Pods::const_iterator it) const
{
  const Amphipod& buddy = bud(begin, end, std::distance(begin, it));

  if(_rooms[it->type() - 'A'] == it->pos())
  {
    if(it->depth() == _hallway + 1)
      return buddy.pos() != it->pos();
    // everything is right
    return false;
  }

  for(Pods::const_iterator j = begin; j != end; ++j)
  {
    if(&*j == &buddy || j == it)
      continue;

    // I'm blocked in
    if(it->depth() == _hallway + 2 && j->pos() == it->pos())
    {
      return false;
    }

    if(it->energy() > 0)
    {
      // I'm blocked out
      if(j->pos() == _rooms[it->type() - 'A'])
        return false;
    }
  }

  return true;
}

const Amphipod& Burrow::bud(Pods::const_iterator begin, Pods::const_iterator end, size_t i) const
{
  const Burrow::Pair& buds = _buddies.find((begin + i)->type())->second;
  size_t bud = i == buds.first ? buds.second : buds.first;
  return *(begin + bud);
}

template <typename M>
void insert(M& map, char type, size_t i)
{
  auto r = map.insert(typename M::value_type(type, std::make_pair<size_t,size_t>(0, 0)));
  if(r.second)
    r.first->second.first = i;
  else
    r.first->second.second = i;
}

std::istream& operator>>(std::istream& is, Burrow& b)
{
  std::string line;
  size_t depth = 0;
  while(std::getline(is, line))
  {
    size_t s = line.find('.');
    if(s < line.size() && s < b._min)
      b._min = s;

    s = line.rfind('.');
    if(s < line.size() && s > b._max)
      b._max = s;

    if(s != std::string::npos)
      b._hallway = depth;

    for(size_t f = 0; (f = line.find_first_of("ABCD", f)) != std::string::npos; ++f)
    {
      b._pods.emplace_back(line[f], f, depth);
      if(b._rooms.empty() || b._rooms.back() < f)
        b._rooms.push_back(f);

      insert(b._buddies, line[f], b._pods.size()-1);
    }

    ++depth;
  }

  return is;
}

