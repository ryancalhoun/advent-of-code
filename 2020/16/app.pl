#!/usr/bin/perl

use strict;
use warnings;

sub slurp
{
  my ($pat,$cb) = @_;

  my @result;

  while(<>)
  {
    chomp;
    last unless $_;

    if(my @m = m/$pat/g)
    {
      $cb and $cb->(@m) or push @result, \@m;
    }
  }
  @result;
}

sub invalid_field
{
  my ($fields,$ticket) = @_;

  for my $v (@$ticket)
  {
    return $v unless(grep { $_->($v) } values %$fields);
  }

  return -1;
}

sub find_invalid_fields
{
  my ($fields,$ticket,@nearby) = @_;

  my $invalid;
  for(@nearby)
  {
    my $f = &invalid_field($fields, $_);
    $invalid += $f if $f > 0;
  }

  $invalid;
}

sub eliminate
{
  my %actual;
  my $possible = shift;

  until(scalar keys %actual == scalar keys %$possible)
  {
    for(keys %$possible)
    {
      my @cols = keys %{$possible->{$_}};

      if(scalar @cols == 1)
      {
        $actual{$_} = $cols[0];
        delete $_->{$cols[0]} for values %$possible;
        last;
      }
    }
  }
  %actual;
}

sub identify_fields
{
  my ($fields,$ticket,@nearby) = @_;
  @nearby = grep { &invalid_field($fields, $_) == -1 } @nearby;

  my %possible = map { $_ => {} } keys %$fields;
  for my $i (0..$#{$nearby[0]})
  {
    for my $field (keys %$fields)
    {
      $possible{$field}->{$i} = 1 unless grep { !$fields->{$field}->($_->[$i]) } @nearby;
    }
  }

  my %actual = &eliminate(\%possible);


  my $dep = 1;
  $dep *= $ticket->[$actual{$_}] for grep { /^departure/ } keys %actual;

  $dep;
}

sub main
{
  my %fields;

  &slurp(qr/(.+): (\d+)-(\d+) or (\d+)-(\d+)/, sub { 
    my ($f,@r) = @_;
    $fields{$f} = sub {
      my $x = shift;
      ($r[0] <= $x && $x <= $r[3]) && ($x <= $r[1] || $x >= $r[2]);
    };
  });

  my ($ticket) = &slurp(qr/\d+/);
  my @nearby = &slurp(qr/\d+/);

  my $scan_tickets = $ENV{PART} == 1 ? \&find_invalid_fields : \&identify_fields;

  print $scan_tickets->(\%fields, $ticket, @nearby), $/;
};

__PACKAGE__->main unless caller;
