#!/usr/bin/perl

use strict;
use warnings;

sub count
{
  my ($min, $max, $char, $pw) = @_;
  my $count = length($pw =~ s/[^\Q$char\E]//rg);
  return $min <= $count && $count <= $max;
}

sub contains_one
{
  my ($i, $j, $char, $pw) = @_;
  return (substr($pw, $i-1, 1) eq $char xor substr($pw, $j-1, 1) eq $char);
}

sub main
{
  my $valid = 0;
  my $is_valid = $ENV{PART} == '1' ? \&count : \&contains_one;
  while(<>)
  {
    ++$valid if &$is_valid(/(\d+)-(\d+)\s(\w):\s(\w+)/);
  } 

  print "$valid\n";
};

__PACKAGE__->main unless caller;
