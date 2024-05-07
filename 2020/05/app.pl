#!/usr/bin/perl

use strict;
use warnings;

sub num
{
  my ($chr, $str) = @_;

  my $num = 0;
  for(split //, $str)
  {
    $num <<= 1;
    $num |= 1 if $_ eq $chr;
  }

  $num
}

sub missing
{
  my $missing = $_[0];

  for(@_)
  {
    return $missing if $missing != $_;
    $missing = $_ + 1;
  }
}

sub main
{
  my @id;
  while(<>)
  {
    my ($r, $c) = /([BF]{7})([RL]{3})/;
    my $row = &num('B', $r);
    my $col = &num('R', $c);
    push @id, $row * 8 + $col;
  }

  @id = sort { $a <=> $b } @id;

  if($ENV{PART} == '1')
  {
    print $id[$#id], $/;
  }
  else
  {
    print &missing(@id), $/;
  }
};

__PACKAGE__->main unless caller;
