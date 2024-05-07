#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Group;

sub main
{
  my @group = (Group->new);

  while(<>)
  {
    chomp;

    if($_)
    {
      $group[$#group]->inc(split //);
    }
    else
    {
      push @group, Group->new;
    }
  }

  my $total;

  for(@group)
  {
    $_->trim() if $ENV{PART} == 2;
    $total += $_->size();
  }

  print $total, $/;
};

__PACKAGE__->main unless caller;
