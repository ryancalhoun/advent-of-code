#include "paper.h"
#include "point.h"
#include "instruction.h"

#include <istream>

Paper::Paper()
  : _width(0)
  , _height(0)
  , _ready(false)
{}

bool Paper::ready() const
{
  return _ready;
}

void Paper::fold(const Instruction& inst)
{
  std::set<Point> folded;
  for(auto p : _points)
    folded.insert(p.reflect(inst.axis(), inst.position()));

  _points = folded;

  if(inst.axis() == 'x')
    _width = inst.position();
  else
    _height = inst.position();
}

size_t Paper::count() const
{
  return _points.size();
}

size_t Paper::width() const
{
  return _width;
}

size_t Paper::height() const
{
  return _height;
}

void Paper::add(int x, int y)
{
  if(x + 1 > _width)
    _width = x + 1;
  if(y + 1 > _height)
    _height = y + 1;

  _points.insert(Point(x, y));
}

void Paper::done()
{
  _ready = true;
}

bool Paper::contains(int x, int y) const
{
  return _points.find(Point(x, y)) != _points.end();
}

std::istream& operator>>(std::istream& is, Paper& paper)
{
  std::string line;
  std::getline(is, line);  

  if(line.empty())
  {
    paper.done();
  }
  else
  {
    size_t c = line.find(',');
    paper.add(std::stoi(line.substr(0, c)), std::stoi(line.substr(c+1)));
  }

  return is;
}

std::ostream& operator<<(std::ostream& os, const Paper& paper)
{
  for(int y = 0; y < paper.height(); ++y)
  {
    for(int x = 0; x < paper.width(); ++x)
    {
      if(paper.contains(x, y))
        os << '#';
      else
        os << ' ';
    }
    os << std::endl;
  }
  return os;
}

