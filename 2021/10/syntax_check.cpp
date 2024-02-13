#include "syntax_check.h"

SyntaxCheck::SyntaxCheck()
  : _score(0)
{}

void SyntaxCheck::onIllegal(char c)
{
  switch(c)
  {
  case ')':
    _score += 3;
    break;
  case ']':
    _score += 57;
    break;
  case '}':
    _score += 1197;
    break;
  case '>':
    _score += 25137;
    break;
  };
}

void SyntaxCheck::onIncomplete(const std::string& s)
{

}

long long SyntaxCheck::score() const
{
  return _score;
}

