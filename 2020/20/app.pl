#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Tile;

sub main
{
  my %tiles;
  my $tile;

  while(<>)
  {
    chomp;
    next unless $_;

    if(my ($id) = /Tile (\d+):/)
    {
      $tile = $tiles{$id} = Tile->new;
    }
    else
    {
      $tile->push($_);
    }
  }

  my %edges;

  my @ids = keys %tiles;
  for my $i (0..$#ids-1)
  {
    my %a = map { $_ => 1 } $tiles{$ids[$i]}->edges;
    for my $j($i+1..$#ids)
    {
      for($tiles{$ids[$j]}->edges)
      {
        if($a{$_})
        {
          ++$edges{$ids[$i]};
          ++$edges{$ids[$j]};
        }
      }
    }
  }

  my $corners = 1;
  while(my ($id,$n) = each %edges)
  {
    $corners *= $id if $n == 4;
  }

  print $corners, $/;
};

__PACKAGE__->main unless caller;
