#include "scanner.h"
#include <istream>
#include <ostream>
#include <string>
#include <sstream>
#include <set>

Scanner::Scanner()
  : _id(0)
  , _i(0)
  , _j(0)
{}

int Scanner::id() const
{
  return _id;
}

bool Scanner::alignWith(const Scanner& s)
{
  for(int i = 0; i < _beacons.size(); ++i)
  {
    for(int j = 0; j < s._beacons.size(); ++j)
    {
      int dx = s._beacons[i].x() - _beacons[j].x();
      int dy = s._beacons[i].y() - _beacons[j].y();
      int dz = s._beacons[i].z() - _beacons[j].z();

      int same = 0;
      for(const auto& b : _beacons)
      {
        if(s._fixed.find(Beacon(b.x() + dx, b.y() + dy, b.z() + dz)) != s._fixed.end())
          ++same;
      }

      if(same >= 12)
      {
        for(auto& b : _beacons)
          b.shift(dx, dy, dz);
        fix();
        return true;
      }

    }
  }

  return false;
}

bool Scanner::nextTurn()
{
  if(_i == 6)
  {
    _i = 0;
    return false;
  }

  if(_j < 3)
  {
    if(_i % 2 == 0)
      cw();
    else
      ccw();

    ++_j;
  }
  else
  {
    fw();
    _j = 0;
    ++_i;
  }

  return true;
}

void Scanner::fix()
{
  for(const auto& b : _beacons)
    _fixed.insert(b);
}

void Scanner::fw()
{
  for(auto& b : _beacons)
    b.fw();
}

void Scanner::cw()
{
  for(auto& b : _beacons)
    b.cw();
}

void Scanner::ccw()
{
  for(auto& b : _beacons)
    b.ccw();
}

std::set<Beacon>::const_iterator Scanner::begin() const
{
  return _fixed.begin();
}

std::set<Beacon>::const_iterator Scanner::end() const
{
  return _fixed.end();
}

std::istream& operator>>(std::istream& is, Scanner& s)
{
  s._beacons.clear();

  is.ignore(12);
  is >> s._id;

  std::string line;
  std::getline(is, line);

  while(std::getline(is, line))
  {
    if(line.empty())
      break;

    std::istringstream iss(line);
    Beacon b;
    iss >> b;
    s._beacons.push_back(b);
  }

  return is;
}

std::ostream& operator<<(std::ostream& os, const Scanner& s)
{
  os << "--- scanner " << s._id << " ---" << std::endl;
  for(const auto& b : s._beacons)
    os << b << std::endl;

  return os;
}
