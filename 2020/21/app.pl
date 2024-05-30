#!/usr/bin/perl

use strict;
use warnings;

sub main
{
  my %allergens;
  my %ingredients;

  while(<>)
  {
    my ($ing, $all) = /(.*)\(contains (.*)\)/;

    my %ing = map { $_ => 1 } split ' ', $ing;
    ++$ingredients{$_} for keys %ing;

    $allergens{$_} = $allergens{$_} ? [grep { $ing{$_} } @{$allergens{$_}}] : [keys %ing] for split ', ', $all;
  }

  my %notsafe;
  until(scalar %notsafe == scalar %allergens)
  {
    my $unsafe;
    while(my ($a,$i) = each %allergens)
    {
      if(scalar @$i == 1 && !$notsafe{$i->[0]})
      {
        $notsafe{$i->[0]} = $a;
        $unsafe = $i->[0];
        last;
      }
    }

    @$_ = grep { $_ ne $unsafe } @$_ for values %allergens;
  }

  if($ENV{PART} == 1)
  {
    my $total = 0;
    while(my ($i,$n) = each %ingredients)
    {
      next if $notsafe{$i};
      $total += $n;
    }

    print $total, $/;
  }
  else
  {
    print join(',', map { $_->[1] } sort { $a->[0] cmp $b->[0] } map { [$notsafe{$_}, $_] } keys %notsafe), $/;
  }
};

__PACKAGE__->main unless caller;
