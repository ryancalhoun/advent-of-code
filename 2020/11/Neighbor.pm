package Neighbor;

sub range
{
  my ($i, $n) = @_;
  ($i > 0 ? $i-1 : $i) .. ($i < $n-1 ? $i+1 : $i);
}

sub immediate
{
  my ($grid, $i, $j) = @_;

  my $h = scalar @$grid;
  my $w = scalar @{$grid->[0]};

  my @neighbors;

  for my $m (&range($i, $h))
  {
    for my $n (&range($j, $w))
    {
      next if $m == $i && $n == $j;
      push @neighbors, \$grid->[$m]->[$n] unless $grid->[$m]->[$n] == 0;
    }
  }

  @neighbors;
}

sub find_first
{
  my ($grid, $i, $j, $inc) = @_;

  my $h = scalar @$grid;
  my $w = scalar @{$grid->[0]};

  while($i >= 0 && $i < $h && $j >= 0 && $j < $w)
  {
    return \$grid->[$i]->[$j] unless $grid->[$i]->[$j] == 0;
    ($i, $j) = $inc->($i, $j);
  }
  undef;
}

sub visible
{
  my ($grid, $i, $j) = @_;

  my $h = scalar @$grid;
  my $w = scalar @{$grid->[0]};

  grep { defined } (
    &find_first($grid, $i-1, $j, sub { ($_[0]-1, $_[1]) }),
    &find_first($grid, $i-1, $j-1, sub { ($_[0]-1, $_[1]-1) }),
    &find_first($grid, $i-1, $j+1, sub { ($_[0]-1, $_[1]+1) }),
    &find_first($grid, $i+1, $j, sub { ($_[0]+1, $_[1]) }),
    &find_first($grid, $i+1, $j-1, sub { ($_[0]+1, $_[1]-1) }),
    &find_first($grid, $i+1, $j+1, sub { ($_[0]+1, $_[1]+1) }),
    &find_first($grid, $i, $j-1, sub { ($_[0], $_[1]-1) }),
    &find_first($grid, $i, $j+1, sub { ($_[0], $_[1]+1) }),
  );
}

1;
