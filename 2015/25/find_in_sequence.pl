#!/usr/bin/perl

my $n = int <>;
my $v = 20151125;

for (1..$n-1) {
  $v = $v * 252533 % 33554393;
}
print $v, $/;
