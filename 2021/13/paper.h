#pragma once

#include <set>
#include <iosfwd>

class Point;
class Instruction;

class Paper
{
public:
  Paper();

  bool ready() const;
  void fold(const Instruction& inst);
  size_t count() const;
  size_t height() const;
  size_t width() const;

  void add(int x, int y);
  void done();
  bool contains(int x, int y) const;

protected:
  std::set<Point> _points;
  size_t _width;
  size_t _height;
  bool _ready;
};

std::istream& operator>>(std::istream& is, Paper& p);
std::ostream& operator<<(std::ostream& os, const Paper& p);
