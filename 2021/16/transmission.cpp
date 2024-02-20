#include "transmission.h"
#include "bit_stream.h"

#include "packet.h"

Transmission::Transmission(BitStream& stream)
  : _stream(stream)
{}

long long Transmission::decode(long long (*eval)(const Packet&)) const
{
  int version = _stream.get(3);
  int type = _stream.get(3);

  if(type == 4)
  {
    long long value = 0;
    int n;
    do
    {
      n = _stream.get(5);
      value <<= 4;
      value += n & 0xf;
    } while((n & 0x10) != 0);

    return (*eval)(Packet(version, type, std::vector<long long> { value }));
  }
  else
  {
    std::vector<long long> args;

    if(_stream.get(1) == 0)
    {
      const size_t bits = _stream.get(15);
      const size_t p0 = _stream.tell();
      while(_stream.tell() - p0 < bits)
        args.push_back(decode(eval));
    }
    else
    {
      const size_t n = _stream.get(11);
      for(size_t i = 0; i < n; ++i)
        args.push_back(decode(eval));
    }

    return (*eval)(Packet(version, type, args));
  }
}

