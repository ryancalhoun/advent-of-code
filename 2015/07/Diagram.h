#pragma once

#include <string>
#include <map>
#include <vector>
#include <functional>
#include <iosfwd>

class Diagram
{
public:
  using Tester = std::function<bool(const std::vector<std::string>&, unsigned&)>;
  void trace(Tester t);
  void reset();
  void override(const std::string& name, unsigned value);

  unsigned signal(const std::string& out) const;

protected:
  void add(const std::string& out, const std::string& in);
  std::string get(const std::string& name) const;
  friend std::istream& operator>>(std::istream& is, Diagram& d);

protected:
  std::map<std::string,std::vector<std::string> > _diagram;
  std::map<std::string,unsigned> _signals;
  std::map<std::string,unsigned> _override;
};
