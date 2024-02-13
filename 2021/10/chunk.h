#pragma once

#include <string>

class OnError;

class Chunk
{
public:
  Chunk(OnError& onError);

  void parse(const std::string& line);

protected:
  OnError& _onError;
};


