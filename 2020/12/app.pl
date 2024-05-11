#!/usr/bin/perl

use strict;
use warnings;

sub main
{
  my @boat = (0, 0);
  my @point = (1, 0);

  my %direction = (
     90 => sub { @point = (-$point[1], $point[0]) },
    180 => sub { @point = (-$point[0], -$point[1]) },
    270 => sub { @point = ($point[1], -$point[0]) },
  );

  my %update = (
    N => sub { $boat[1] -= $_[0] },
    S => sub { $boat[1] += $_[0] },
    E => sub { $boat[0] += $_[0] },
    W => sub { $boat[0] -= $_[0] },
    L => sub { $direction{-$_[0] % 360}->() },
    R => sub { $direction{$_[0]}->() },
    F => sub { $boat[0] += $point[0] * $_[0]; $boat[1] += $point[1] * $_[0] },
  );

  if($ENV{PART} == 2)
  {
    @point = (10, -1);
    $update{N} = sub { $point[1] -= $_[0] };
    $update{S} = sub { $point[1] += $_[0] };
    $update{E} = sub { $point[0] += $_[0] };
    $update{W} = sub { $point[0] -= $_[0] };
  }

  while(<>)
  {
    my ($action, $value) = /([NSEWLRF])(\d+)/;
    $update{$action}->($value);
  }

  print abs($boat[0]) + abs($boat[1]), $/;
};

__PACKAGE__->main unless caller;
