# Day 16: Packet Decoder

[Full info here](https://adventofcode.com/2021/day/16)

For the data structure, I chose a vector of bool. The only way to access
the data is to pull `n` bits from the front as an integer. Whether a loop
over literal nibbles, a subpacket count or a bit limit, the packet protocol
always comes down to consuming a specified number of bits as an integer.

The first wrinkle was integer overflow, hence the `long long` integers.

The second was my initial use of the bit values as a loop condition. Beware
zero bytes--they are legal.

The last was my own desire to write a single iteration of packets and
subpackets that would satisfy both part one and two. I accomplished this by
crafting my subpacket traversal to be bottom-up, so that the leaf literals
all get evaluated before their parents. This is necessary for the operator
evaluation, and doesn't harm the version summation.
