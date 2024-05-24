#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Grid;

sub main
{
  my $g = Grid->new;
  my $y = 0;
  my @z = (0);

  push @z, 0 if $ENV{PART} == 2;

  while(<>)
  {
    chomp;
    my @row = split //;
    for my $x(0..$#row)
    {
      $g->set($x, $y, @z) if $row[$x] eq '#';
    }

    ++$y;
  }

  $g->cycle for 1..6;

  print $g->count, $/;
};

__PACKAGE__->main unless caller;
