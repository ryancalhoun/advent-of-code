#pragma once

class Packet;
class BitStream;

class Transmission
{
public:
  Transmission(BitStream& stream);

  long long decode(long long (*eval)(const Packet&)) const;

protected:
  BitStream& _stream;
};
