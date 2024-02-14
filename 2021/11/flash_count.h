#pragma once

#include <cstddef>

class FlashCount
{
public:
  FlashCount();

  operator size_t() const;
  operator bool() const;
  void operator()(size_t flashes);

protected:
  size_t _total;
  size_t _steps;
};
