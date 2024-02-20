#include "packet.h"

Packet::Packet(int version, int type, const std::vector<long long>& args)
  : _version(version)
  , _type(type)
  , _args(args)
{}

int Packet::version() const
{
  return _version;
}

int Packet::type() const
{
  return _type;
}

const std::vector<long long>& Packet::args() const
{
  return _args;
}

long long Packet::versionCheck(const Packet& p)
{
  long long v = p.version();

  if(p.type() != 4)
    for(long long arg : p.args())
      v += arg;

  return v;
}

namespace
{
  long long sum(const Packet& p)
  {
    long long v = 0;
    for(long long arg : p.args())
      v += arg;

    return v;
  }
  long long prod(const Packet& p)
  {
    long long v = 1;
    for(long long arg : p.args())
      v *= arg;

    return v;
  }
  long long min(const Packet& p)
  {
    long long v = p.args().front();
    for(long long arg : p.args())
      v = arg < v ? arg : v;

    return v;
  }
  long long max(const Packet& p)
  {
    long long v = p.args().front();
    for(long long arg : p.args())
      v = arg > v ? arg : v;

    return v;
  }
  long long literal(const Packet& p)
  {
    return p.args().front();
  }
  long long gt(const Packet& p)
  {
    return p.args().front() > p.args().back() ? 1 : 0;
  }
  long long lt(const Packet& p)
  {
    return p.args().front() < p.args().back() ? 1 : 0;
  }
  long long eq(const Packet& p)
  {
    return p.args().front() == p.args().back() ? 1 : 0;
  }

  long long (*value[])(const Packet& p) = {
    sum,
    prod,
    min,
    max,
    literal,
    gt,
    lt,
    eq,
  };
}

long long Packet::valueOf(const Packet& p)
{
  return (*value[p.type()])(p);
}

