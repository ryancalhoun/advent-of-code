#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Circle;

sub main
{
  my $cups = Circle->new;

  $cups->push(m/\d/g) while <>;

  $cups->move for 1..100;

  print $cups->final, $/;
};

__PACKAGE__->main unless caller;
