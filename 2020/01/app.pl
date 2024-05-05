#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(any);

sub find_if
{
  my $target = shift;
  my $if = shift;

  for my $n(@_)
  {
    my $diff = $target - $n;

    my @result = &$if($diff, @_);
    if(scalar @result > 0)
    {
      return (@result, $n);
    }
  }
  return ();
}

sub if_pair
{
  my $x = shift;
  if(any { $_ == $x } @_)
  {
    return ($x);
  }
  return ();
};

sub if_triple
{
  my $x = shift;
  return &find_if($x, \&if_pair, @_);
};

sub main
{
  my @numbers = <>;
  chomp @numbers;

  my $find_numbers = $ENV{PART} == 1 ? \&if_pair : \&if_triple;

  my $product = 1;
  for(&find_if(2020, $find_numbers, @numbers))
  {
    $product *= $_;
  }

  print "$product\n";
};

__PACKAGE__->main unless caller;
