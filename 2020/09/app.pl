#!/usr/bin/perl

use strict;
use warnings;

use List::Util;

sub find_seq
{
  my $target = shift;

  for(my $i = $#_ - 1; $i >= 0; --$i)
  {
    for(my $j = $#_; $j > $i; --$j)
    {
      my @range = sort @_[$i..$j];
      my $sum = List::Util::sum(@range);

      last if $sum < $target;
      return $range[0] + $range[-1] if $sum == $target;
    }
  }
}

sub main
{
  my @numbers;
  my $w = $ENV{WINDOW} or die;

  while(<>)
  {
    my $x = int $_;
    push @numbers, { value => $x };

    if(scalar @numbers > $w)
    {
      last if List::Util::none { $_->{$x} } @numbers[-$w-1..-2];
    }

    for(my $i = $#numbers - 1; $i >= 0 && $#numbers - $i <= $w; --$i)
    {
      ++$numbers[$i]->{$x + $numbers[$i]->{value}}
    }
  }

  my $invalid = (pop @numbers)->{value};

  if($ENV{PART} == 1)
  {
    print $invalid, $/;
  }
  else
  {
    print &find_seq($invalid, map { $_->{value} } @numbers), $/;
  }

};

__PACKAGE__->main unless caller;
