#!/usr/bin/perl

use strict;
use warnings;
use feature qw/current_sub/;

sub play
{
  my ($p1, $p2, $fn) = @_;

  my %seen;

  for(my $round = 1; ; ++$round)
  {
    my $hand = join(',', @$p1) . '/' . join(',', @$p2);
    return $p1 if ++$seen{$hand} > 1;

    my ($c1, $c2) = map { shift @{$_} } ($p1, $p2);

    if($fn->($c1, $c2, $p1, $p2))
    {
      push @{$p1}, $c1, $c2;
    }
    else
    {
      push @{$p2}, $c2, $c1;
    }

    return $p2 unless @$p1;
    return $p1 unless @$p2;
  }
}

sub score
{
  my ($winner) = @_;

  my $total = 0;
  $total += ($_+1) * $winner->[-1 - $_] for 0..$#{$winner};

  $total;
}

sub main
{
  my @players;

  while(<>)
  {
    chomp;
    next unless $_;

    if(/Player (\d+):/)
    {
      push @players, [];
    }
    else
    {
      push @{$players[-1]}, $_;
    }
  }

  my $compare = $ENV{PART} == 1 ? sub { $_[0] > $_[1]; } : sub {
    my ($c1, $c2, $p1, $p2) = @_;

    if($c1 <= @$p1 && $c2 <= @$p2)
    {
      my $q1 = [ @$p1[0..$c1-1] ];
      my $q2 = [ @$p2[0..$c2-1] ];

      &play($q1, $q2, __SUB__) == $q1;
    }
    else
    {
      $c1 > $c2;
    }
  };

  my $winner = &play(@players, $compare);

  print &score($winner), $/;
};

__PACKAGE__->main unless caller;
