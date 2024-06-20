#!/usr/bin/perl
use strict;
use warnings;

pipe my $r, my $w;

my $pid = fork;
if(! $pid) {
  close $w;
  open STDIN, "<&", $r;
  exec qw (node -);
}
close $r;
select $w;

my $machine = {};

while(<>) {
  chomp;
  last unless $_;

  my ($in,$out) = /(\w+) => (\w+)/;

  $machine->{$in} = [] unless exists $machine->{$in};
  push @{$machine->{$in}}, $out;
}

my $molecule = <>;
chomp $molecule;

print "const machine = {";
while(my ($k,$v) = each %$machine) {
  print "$k:[";
  print "\"$_\"," for @$v;
  print "],";
}
print "}; const molecule = \"$molecule\";";

my $fun = $ENV{PART} eq 1 ? 'countReplacements' : 'countFabrication';
print "console.log(require('./molecule.js').$fun(machine, molecule));";
close $w;
waitpid $pid, 0;
