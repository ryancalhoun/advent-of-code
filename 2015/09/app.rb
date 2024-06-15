#!/usr/bin/env ruby

exec 'perl', '-x', __FILE__ if ARGV.empty?

=begin
#!perl

sub cost {
  my $h = shift;
  my $total = 0;
  for(my $i = 0; $i < $#_; ++$i) {
    my $hop = $h->{$_[$i]}->{$_[$i+1]};
    return unless $hop;

    $total += $hop;
  }

  $total;
}

sub main {
  my $h = {};

  while(<>) {
    my ($a,$b,$d) = /(\w+) to (\w+) = (\d+)/;

    $h->{$a} = {} unless exists $h->{$a};
    $h->{$b} = {} unless exists $h->{$b};

    $h->{$a}->{$b} = $d;
    $h->{$b}->{$a} = $d;
  }

  my $min, $max;

  my @cities = keys %$h;
  open my $rb, "$0 @cities|";
  while(<$rb>) {
    chomp;
    my $cost = &cost($h, split / /);
    next unless $cost;

    $min = $cost unless $min && $min < $cost;
    $max = $cost unless $max && $max > $cost;
  }

  if($ENV{PART} == 1) {
    print $min, $/;
  } else {
    print $max, $/;
  }
}

&main;
__END__
=end

ARGV.permutation.each do |p|
  puts p.join(' ')
end
