#pragma once

#include <map>
#include <string>

class Visitor
{
public:
  Visitor(int smallCaveRepeat);

  bool done() const;
  const std::string& current() const;
  bool canVisit(const std::string& cave) const;

  Visitor visit(const std::string& cave) const;

protected:
  void add(const std::string& cave);

protected:
  int _smallCaveRepeat;
  std::string _current;
  std::map<std::string,int> _visited;
};

