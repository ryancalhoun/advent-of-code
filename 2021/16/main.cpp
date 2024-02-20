#include "packet.h"
#include "bit_stream.h"
#include "transmission.h"

#include <iostream>

int main(int argc, char* const argv[], char* const envp[])
{
  long long (*eval)(const Packet&) = &Packet::versionCheck;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      eval = &Packet::valueOf;

  BitStream s;
  while(std::cin >> s)
    std::cout << Transmission(s).decode(eval) << std::endl;
}
