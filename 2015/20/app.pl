#!/usr/bin/perl
use strict;
use warnings;

use List::Util qw (min);

my $target = int <>;

if($ENV{PART} == '1') {
  $target /= 10;
} else {
  $target /= 11;
  $ENV{LIMIT} = '50';
}

pipe my $r_in, my $w_in;
pipe my $r_out, my $w_out;

my $pid = fork;
if(! $pid) {
  close $w_in;
  close $r_out;
  open STDIN, "<&", $r_in;
  open STDOUT, ">&", $w_out;

  exec qw (java SumOfFactors);
}
close $r_in;
close $w_out;

$w_in->autoflush(1);

sub gen {
  my ($p, $m, $i, $f) = @_;

  if($i == $m) {
    print $w_in join(' ', @$p), $/;
    my ($n,$sum) = split ' ', <$r_out>;
    $f->(int $n, int $sum);
    return;
  }

  for(0..$m-$i) {
    $p->[$i] = $_;
    &gen($p, $m, $i+1, $f);
  }
}

my @v;
for(my $length = 1; $length < 7; ++$length) {

  &gen([], $length, 0, sub {
    my ($n, $sum) = @_;
    if($sum >= $target) {
      push @v, $n;
    }
  });

}

close $w_in;
waitpid $pid, 0;

print min(@v), $/;
