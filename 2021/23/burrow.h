#pragma once

#include "amphipod.h"

#include <deque>
#include <map>
#include <set>
#include <iosfwd>

class Burrow
{
public:
  Burrow();

  size_t sort();

protected:
  friend std::istream& operator>>(std::istream& is, Burrow& b);

protected:
  using Rooms = std::deque<size_t>;
  using Pods = std::deque<Amphipod>;
  using Pair = std::pair<size_t,size_t>;
  using Buddies = std::map<char,Pair>;

  size_t sort(const Pods& pods, size_t min_energy) const;

  size_t energy(const Pods& pods) const;
  bool all_sorted(const Pods& pods) const;

  bool should_move(Pods::const_iterator begin, Pods::const_iterator end, Pods::const_iterator it) const;
  void possible(Pods::const_iterator begin, Pods::const_iterator end, Pods::const_iterator it, std::set<size_t>& positions) const;

  const Amphipod& bud(Pods::const_iterator begin, Pods::const_iterator end, size_t i) const;

protected:

  Pods _pods;
  Rooms _rooms;
  Buddies _buddies;

  size_t _min;
  size_t _max;
  size_t _hallway;
};
