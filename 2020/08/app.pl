#!/usr/bin/perl

use strict;
use warnings;

BEGIN { unshift @INC, '.' }
use Program;

sub run_until_infinite_loop
{
  eval { &Program::run(@_) };
  int $@;
}

sub fix_infinite_loop
{
  my %flip = ( nop => 'jmp', jmp => 'nop' );

  for my $i (0..$#_)
  {
    my $op = $_[$i]->[0];
    my $flipped = $flip{$op};

    if($flipped)
    {
      $_[$i]->[0] = $flipped;
      my $result = eval { &Program::run(@_) };

      return $result unless $@;
    }

    $_[$i]->[0] = $op;
  }
}

sub main
{
  my @program;

  while(<>)
  {
    my ($op, $arg) = /(\w+) ([+\-]\d+)/;
    push @program, [$op, $arg];
  }

  my $run = $ENV{PART} == 1 ? \&run_until_infinite_loop : \&fix_infinite_loop;

  print $run->(@program), $/;
};

__PACKAGE__->main unless caller;
