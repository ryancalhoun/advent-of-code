#!/usr/bin/perl

use strict;
use warnings;

sub valid
{
  my $p = shift;
  my $rules = shift;

  for(keys %$rules)
  {
    return 0 unless exists($p->{$_}) && $rules->{$_}->($p->{$_});
  }

  return 1;
}

sub exists
{
  return shift;
}

sub range
{
  my ($x, $min, $max) = @_;
  return $min <= $x && $x <= $max;
}

sub if_suffix
{
  my $suff = shift;
  my $x = shift;
  return 0 unless $x =~ /\d+$suff/;

  my ($num) = $x =~ /(\d+)/;
  return &range($num, @_);
}

sub main
{
  my @passports = ({});

  while(<>)
  {
    chomp;

    push @passports, {} unless $_;

    for(split /\s+/)
    {
      my ($k,$v) = split /:/;
      $passports[$#passports]->{$k} = $v;
    }
  }

  my %rules;

  if($ENV{PART} == '1')
  {
    $rules{$_} = \&exists for qw/byr iyr eyr hgt hcl ecl pid/;
  }
  else
  {
    %rules = (
      byr => sub { return &range($_[0], 1920, 2002); },
      iyr => sub { return &range($_[0], 2010, 2020); },
      eyr => sub { return &range($_[0], 2020, 2030); },
      hgt => sub { return &if_suffix('cm', $_[0], 150, 193) || &if_suffix('in', $_[0], 59, 76); },
      hcl => sub { return $_[0] =~ /#[0-9a-f]{6}/; },
      ecl => sub { return grep { $_ eq $_[0] } qw/amb blu brn gry grn hzl oth/; },
      pid => sub { return $_[0] =~ /^\d{9}$/; }
    );
  }

  my $valid = 0;
  $valid += &valid($_, \%rules) for @passports;

  print $valid, $/;
};

__PACKAGE__->main unless caller;
