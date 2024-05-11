#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Neighbor;

sub link
{
  my ($grid, $neighbors) = @_;
  my $seats = [];

  for my $i (0..$#{$grid})
  {
    for my $j (0..$#{$grid->[0]})
    {
      next if $grid->[$i]->[$j] == 0;

      my $seat = [\$grid->[$i]->[$j], []];
      push @{$seat->[1]}, $neighbors->($grid, $i, $j);

      push @$seats, $seat;
    }
  }

  $seats;
}

sub update
{
  my ($seats, $limit) = @_;

  for(@$seats)
  {
    my ($seat, $neighbors) = @$_;

    my $occupied = scalar grep { $$_ > 0 } @$neighbors;
    ++$$seat if $$seat > 0 && $occupied >= $limit;
    --$$seat if $$seat < 0 && $occupied == 0;
  }

  my $changes = 0;
  for(@$seats)
  {
    my $seat = $_->[0];
    ++$changes and $$seat = 1 if $$seat < -1;
    ++$changes and $$seat = -1 if $$seat > 1;
  }

  $changes;
}

sub count
{
  my $seats = shift;
  scalar grep { ${$_->[0]} > 0 } @$seats;
}

sub main
{
  my @seats;

  while(<>)
  {
    chomp;
    push @seats, [map { $_ eq 'L' ? -1 : 0 } split //];
  }

  my $linked = &link(\@seats, $ENV{PART} == 1 ? \&Neighbor::immediate : \&Neighbor::visible);

  for(;;)
  {
    last if &update($linked, $ENV{PART} == 1 ? 4 : 5) == 0;
  }

  print &count($linked), $/;
};

__PACKAGE__->main unless caller;
