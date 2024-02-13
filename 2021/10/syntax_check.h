#pragma once

#include "on_error.h"

class SyntaxCheck : public OnError
{
public:
  SyntaxCheck();

  void onIllegal(char c);
  void onIncomplete(const std::string& s);
  long long score() const;

protected:
  long long _score;
};
