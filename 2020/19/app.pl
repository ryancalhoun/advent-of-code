#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Rule;
use RuleSet;

sub main
{
  my $rules = RuleSet->new;

  while(<>)
  {
    chomp;
    last unless $_;

    my ($id,$rule) = split /:\s*/;
    $rules->{$id} = Rule->new($rule);
  }

  if($ENV{PART} == 2)
  {
    $rules->{8}->add(42, 8);
    $rules->{11}->add(42, 11, 31);
  }

  my $matching = 0;
  while(<>)
  {
    chomp;
    ++$matching if $rules->match($_);
  }

  print $matching, $/;
};

__PACKAGE__->main unless caller;
