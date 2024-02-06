#pragma once

#include <vector>
#include <string>

class Diagnostic
{
public:
  Diagnostic();

  void add(unsigned num, size_t degree);
  void add(const std::string& num);

  unsigned powerConsumption() const;
  unsigned lifeSupport() const;

protected:
  std::vector<unsigned> _report;
  size_t _degree;
};

