#include "window.h"
#include <numeric>

Window::Window(size_t size)
  : _size(size)
{}

void Window::add(int measurement)
{
  _measurements.push_back(measurement);
  if(_measurements.size() > _size)
    _measurements.pop_front();
}

bool Window::operator>(const Window& other) const
{
  if(! full() || ! other.full())
    return false;

  return sum() > other.sum();
}

int Window::sum() const
{
  return std::accumulate(_measurements.begin(), _measurements.end(), 0);
}

bool Window::full() const
{
  return _measurements.size() >= _size;
}

