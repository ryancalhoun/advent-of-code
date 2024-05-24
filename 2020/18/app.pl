#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Expression;
use LeftToRight;
use AddBeforeMultiply;

sub main
{
  my $expr = Expression->new($ENV{PART} == 1 ? \&LeftToRight::evaluate : \&AddBeforeMultiply::evaluate);

  my $sum = 0;
  $sum += $expr->evaluate($_) while <>;

  print $sum, $/;
};

__PACKAGE__->main unless caller;
