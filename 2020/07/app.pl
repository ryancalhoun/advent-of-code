#!/usr/bin/perl

use strict;
use warnings;

use List::Util;

BEGIN { unshift @INC, '.' }
use Count;

sub main
{
  my %rules;

  while(<>)
  {
    my ($color) = /([\w\s]+) bags contain/;
    $rules{$color} = {};

    my @contains = /(?: (\d+|no) ([\w\s]+) bags?,?)/g;

    for(List::Util::pairs @contains)
    {
      $rules{$color}->{$_->value} = $_->key if $_->key ne 'no';
    }
  }

  my $count = $ENV{PART} == 1 ? \&Count::parents : \&Count::children;

  print $count->('shiny gold', \%rules), $/;
}

__PACKAGE__->main unless caller;
