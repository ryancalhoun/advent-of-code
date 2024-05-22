#!/usr/bin/perl

use strict;
use warnings;

sub main
{
  my @input;
  push @input, /\d+/g while <>;

  my %turn;
  $turn{$input[$_]} = $_ + 1 for 0..$#input;

  my $last = $input[-1];
  for(scalar @input + 1 .. ($ENV{PART} == 1 ? 2020 : 30000000))
  {
    my $next = 0;

    $next = $_ - $turn{$last} - 1 if $turn{$last};
    $turn{$last} = $_ - 1;

    $last = $next;
  }

  print $last, $/;
};

__PACKAGE__->main unless caller;
