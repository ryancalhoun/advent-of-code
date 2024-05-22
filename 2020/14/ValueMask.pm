package ValueMask;

sub new
{
  bless {
    mem => {}
  }
}

sub mask
{
  my ($this,$mask) = @_;
  my @bits = split //, $mask;

  my $select = sub
  {
    my $val = shift;
    my $x = 0;
    for(@bits)
    {
      $x <<= 1;
      $x |= 1 if ($val && $_ eq 1) || (!$val && $_ ne 0);
    }
    $x;
  };

  $this->{ones} = $select->(1);
  $this->{zeroes} = $select->(0);
}

sub set
{
  my ($this,$loc,$val) = @_;
  $this->{mem}->{$loc} = $val & $this->{zeroes} | $this->{ones};
}

sub sum
{
  my ($this) = @_;
  my $sum = 0;
  $sum += $_ for values %{$this->{mem}};
  $sum
}

1;
