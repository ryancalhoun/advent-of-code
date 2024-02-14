#pragma once

#include <cstddef>

class WaitForAll
{
public:
  WaitForAll();

  operator size_t() const;
  operator bool() const;
  void operator()(size_t flashes);

protected:
  size_t _steps;
  size_t _seen;
};

