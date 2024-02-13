#pragma once

#include <string>

class OnError
{
public:
  virtual ~OnError() {}

  virtual void onIllegal(char c) = 0;
  virtual void onIncomplete(const std::string& s) = 0;

  virtual long long score() const = 0;
};
