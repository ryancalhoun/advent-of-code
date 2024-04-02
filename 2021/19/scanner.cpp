#include "scanner.h"
#include <istream>
#include <ostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <set>

Scanner::Scanner()
  : _id(0)
  , _x(0)
  , _y(0)
  , _z(0)
  , _i(0)
  , _j(0)
{}

int Scanner::id() const
{
  return _id;
}

int Scanner::x() const
{
  return _x;
}

int Scanner::y() const
{
  return _y;
}

int Scanner::z() const
{
  return _z;
}

bool Scanner::alignWith(const Scanner& s)
{
  for(int i = 0; i < _beacons.size() - 11; ++i)
  {
    for(int j = 0; j < s._beacons.size() - 11; ++j)
    {
      int dx = s._beacons[i].x() - _beacons[j].x();
      int dy = s._beacons[i].y() - _beacons[j].y();
      int dz = s._beacons[i].z() - _beacons[j].z();

      int same = 0;

      for(int m = 0, n = 0; m < _beacons.size() && n < s._beacons.size();)
      {
        Beacon b = _beacons[m].offset(dx, dy, dz);

        if(b < s._beacons[n])
          ++m;
        else if(s._beacons[n] < b)
          ++n;
        else
          ++same, ++m, ++n;

        if(same >= 12)
          return moveTo(dx, dy, dz);
      }
    }
  }

  return false;
}

bool Scanner::moveTo(int x, int y, int z)
{
  _x = x;
  _y = y;
  _z = z;

  for(auto& b : _beacons)
    b.shift(x, y, z);

  //fix();

  return true;
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

  std::sort(_beacons.begin(), _beacons.end());

  return true;
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

std::vector<Beacon>::const_iterator Scanner::begin() const
{
  return _beacons.begin();
}

std::vector<Beacon>::const_iterator Scanner::end() const
{
  return _beacons.end();
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
  std::sort(s._beacons.begin(), s._beacons.end());

  return is;
}

std::ostream& operator<<(std::ostream& os, const Scanner& s)
{
  os << "--- scanner " << s._id << " ---" << std::endl;
  for(const auto& b : s._beacons)
    os << b << std::endl;

  return os;
}
