#pragma once

#include <string>
#include <vector>
#include <map>

class Descrambler
{
public:
  Descrambler(const std::string& line);

  typedef std::vector<int> Output;
  Output::const_iterator begin() const;
  Output::const_iterator end() const;

protected:
  void parse(const std::string& line);
  void descramble();
  void input(const std::string& input);
  void output(const std::string& output);

protected:
  std::vector<std::string> _input;
  std::map<char,size_t> _frequency;
  std::map<char,char> _mapping;

  Output _output;
};

