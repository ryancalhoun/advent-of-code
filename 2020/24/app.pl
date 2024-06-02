#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Hex;

sub main
{
  my $tiles = Hex->new;

  $tiles->follow_path(/w|e|se|sw|ne|nw/g) while <>;

  if($ENV{PART} == 2)
  {
    $tiles->play_go for 1..100;
  }

  print $tiles->count, $/;
};

__PACKAGE__->main unless caller;
