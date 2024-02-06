#pragma once

#include <string>
#include <vector>
#include <set>

class Bingo
{
public:
  static size_t size;
  Bingo();

  void parse(const std::string& line);

  bool call(int number);
  int score() const;

protected:
  std::vector<int> _numbers;
  std::vector<size_t> _tally;
  std::set<size_t> _called;

  int _last;
};
