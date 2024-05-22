package MemMask;

sub new
{
  bless {
    mem => {}
  };
}

sub mask
{
  my ($this,$mask) = @_;
  $this->{mask} = [split //, $mask];
}

sub set
{
  my ($this,$loc,$val) = @_;

  my @bits = $this->mask_bits($loc);

  my $slice = sub
  {
    my @old = split //, shift;
    my $new = shift;

    my @x;

    for(0..$#bits)
    {
      next if $bits[$_] eq $old[$_];
      next if $bits[$_] eq 'X';

      return -1 if $old[$_] ne 'X';

      push @x, $_;
    }

    for(0..$#x)
    {
      $old[$x[$_]] = int(!$bits[$x[$_]]);
      push @$new, join '', @old;
      $old[$x[$_]] = $bits[$x[$_]];
    }

    scalar @$new;
  };

  for my $key(keys %{$this->{mem}})
  {
    my @slices;
    if($slice->($key, \@slices) > -1)
    {
      $this->{mem}->{$_} = $this->{mem}->{$key} for @slices;
      delete $this->{mem}->{$key};
    }
  }

  $this->{mem}->{join '', @bits} = $val;
}

sub sum
{
  my ($this) = @_;
  my $sum = 0;

  for(keys %{$this->{mem}})
  {
    my $v = $this->{mem}->{$_};
    my $n = tr/X//;
    $v *= 2 for 1..$n;
    $sum += $v;
  }

  $sum
}

sub mask_bits
{
  my ($this,$loc) = @_;

  my @bits;
  for(0..$#{$this->{mask}})
  {
    my $m = $this->{mask}->[-1 - $_];
    unshift @bits, $m eq 0 ? $loc & 1 : $m;
    $loc >>= 1;
  }

  @bits;
}

1;
