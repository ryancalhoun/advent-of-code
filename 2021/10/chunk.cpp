#include "chunk.h"
#include "on_error.h"
#include <deque>

Chunk::Chunk(OnError& onError)
  : _onError(onError)
{}

void Chunk::parse(const std::string& line)
{
  std::deque<char> closing;

  for(char c : line)
  {
    switch(c)
    {
    case '(':
      closing.push_front(')');
      break;

    case '[':
      closing.push_front(']');
      break;

    case '{':
      closing.push_front('}');
      break;

    case '<':
      closing.push_front('>');
      break;

    default:
      if(closing.size() > 0 && c == closing.front())
      {
        closing.pop_front();
      }
      else
      {
        _onError.onIllegal(c);
        return;
      }
    };
  }

  std::string s;
  for(char c : closing)
    s += c;

  _onError.onIncomplete(s);
}

