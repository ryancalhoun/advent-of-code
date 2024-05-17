#!/usr/bin/perl

use strict;
use warnings;

use POSIX;

sub least_wait
{
  my ($t0, @ids) = @_;
  my $arrival = (sort { $a->[1] <=> $b->[1] } map { [$_, POSIX::ceil($t0 / $_) * $_] } grep { /\d+/ } @ids)[0];
  $arrival->[0] * ($arrival->[1] - $t0);
}

sub consecutive_departs
{
  my $t = 1;
  my $step = 1;

  for my $i (0..$#_)
  {
    next if $_[$i] eq 'x';

    $t += $step until ($t + $i) % $_[$i] == 0;
    $step *= $_[$i];
  }

  $t;
}

sub main
{
  my $t0 = int <>;
  my @ids = split ',', <>;

  if($ENV{PART} == 1)
  {
    print &least_wait($t0, @ids), $/;
  }
  else
  {
    print &consecutive_departs(@ids), $/;
  }
};

__PACKAGE__->main unless caller;
