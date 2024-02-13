#pragma once

#include "on_error.h"
#include <vector>

class Autocomplete : public OnError
{
public:
  Autocomplete();

  void onIllegal(char c);
  void onIncomplete(const std::string& s);
  long long score() const;

protected:
  std::vector<long long> _score;
};
