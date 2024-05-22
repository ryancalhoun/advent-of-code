#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use MemMask;
use ValueMask;

sub main
{
  my $chip = $ENV{PART} == 1 ? ValueMask->new : MemMask->new;

  while(<>)
  {
    my ($loc,$val) = /(?:mask|mem\[(\d+)\]) = (\w+)/;

    if($loc)
    {
      $chip->set($loc, $val);
    }
    else
    {
      $chip->mask($val);
    }
  }

  print $chip->sum, $/;
};

__PACKAGE__->main unless caller;
