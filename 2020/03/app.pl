#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.'; }
use Trajectory;

sub main
{
  my @slopes = $ENV{PART} == 1 ? (3) : (1, 3, 5, 7, 0.5);

  my @sleds = ();
  push @sleds, Trajectory->new($_) for @slopes;

  while(<>)
  {
    chomp;
    my @t = split //;

    for my $s (@sleds)
    {
      $s->check(\@t);
      $s->increment();
    }
  }

  my $total = 1;
  $total *= $_->hit() for (@sleds);

  print "$total\n";
};

__PACKAGE__->main unless caller;
