#include "descrambler.h"
#include <algorithm>

namespace
{
  const std::vector<std::string> digits = {
    "abcefg", // 0
    "cf",     // 1
    "acdeg",  // 2
    "acdfg",  // 3
    "bcdf",   // 4
    "abdfg",  // 5
    "abdefg", // 6
    "acf",    // 7
    "abcdefg",// 8
    "abcdfg", // 9
  };
}

Descrambler::Descrambler(const std::string& line)
{
  parse(line);
}

void Descrambler::parse(const std::string& line)
{
  for(size_t begin = 0, end = 0; end != std::string::npos; begin = end + 1)
  {
    end = line.find(' ', begin);
    std::string s = line.substr(begin, end-begin);

    if(_input.size() < 10)
      input(s);
    else if(s == "|")
      descramble();
    else
      output(s);
  }
}

void Descrambler::input(const std::string& input)
{
  for(char c : input)
    ++_frequency[c];

  _input.push_back(input);
}

void Descrambler::descramble()
{
  auto is_four = [](const std::string& s) { return s.size() == digits[4].size(); };
  auto four = std::find_if(_input.begin(), _input.end(), is_four);

  for(const auto& kv : _frequency)
  {
    bool is_in_four = four->find(kv.first) != std::string::npos;
    switch(kv.second)
    {
    case 4:
      _mapping[kv.first] = 'e';
      break;
    case 6:
      _mapping[kv.first] = 'b';
      break;
    case 7:
      _mapping[kv.first] = is_in_four ? 'd' : 'g';
      break;
    case 8:
      _mapping[kv.first] = is_in_four ? 'c' : 'a';
      break;
    case 9:
      _mapping[kv.first] = 'f';
      break;
    }
  }
}

void Descrambler::output(const std::string& output)
{
  std::string out;
  for(char c : output)
    out += _mapping.find(c)->second;

  std::sort(out.begin(), out.end());

  _output.push_back(std::find(::digits.begin(), ::digits.end(), out) - ::digits.begin());
}

Descrambler::Output::const_iterator Descrambler::begin() const
{
  return _output.begin();
}

Descrambler::Output::const_iterator Descrambler::end() const
{
  return _output.end();
}

