#pragma once

#include <string>
#include <deque>

class Fish
{
public:
  Fish(size_t lifetime);

  void parse(const std::string& line);
  void day();

  size_t count() const;

protected:
  std::deque<size_t> _fish;
  size_t _lifetime;
};
