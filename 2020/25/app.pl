#!/usr/bin/perl

use strict;
use warnings;

sub transformer
{
  my ($subject) = @_;

  my $value = 1;

  sub {
    $value *= $subject;
    $value %= 20201227;

    $value;
  };
}

sub main
{
  my ($card, $door) = map { int } <>;
  my %loop;

  my $t = &transformer(7);

  for(my $i = 1; scalar %loop != 2; ++$i)
  {
    my $v = $t->();
    $loop{$card} = $i if $v == $card;
    $loop{$door} = $i if $v == $door;
  }

  my $e = &transformer($card);
  $e->() for 1..$loop{$door}-1;

  print $e->(), $/;
};

__PACKAGE__->main unless caller;
