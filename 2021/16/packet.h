#pragma once

#include <vector>

class Packet
{
public:
  Packet(int version, int type, const std::vector<long long>& args);

  int version() const;
  int type() const;
  const std::vector<long long>& args() const;

  static long long versionCheck(const Packet& p);
  static long long valueOf(const Packet& p);

protected:
  int _version;
  int _type;
  std::vector<long long> _args;
};

