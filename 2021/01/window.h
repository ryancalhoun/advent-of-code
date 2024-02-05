#pragma once
#include <deque>

class Window
{
public:
  Window(size_t size);

  bool operator>(const Window& other) const;

  void add(int measurement);
  int sum() const;
  bool full() const;

protected:
  size_t _size;
  std::deque<int> _measurements;
};

