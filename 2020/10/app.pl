#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Sequence;

sub main
{
  my @adapters = sort { $a <=> $b } map { int } <>;
  unshift @adapters, 0;
  push @adapters, $adapters[-1] + 3;

  my $seq = Sequence->new;

  $seq->push($_) for @adapters;

  my $answer = $ENV{PART} == 1 ?
    $seq->bucket(1) * $seq->bucket(3) :
    $seq->combinations;

  print $answer, $/;
};

__PACKAGE__->main unless caller;
