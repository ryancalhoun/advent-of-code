package Tile;

sub new
{
  bless [];
}

sub push
{
  my ($this, $line) = @_;

  push @$this, [split //, $line];
}

sub edges
{
  my ($this) = @_;

  my @e;

  my $bits = sub
  {
    my $f = 0, $r = 0;

    for my $i (0..$#_)
    {
      $f <<= 1;
      $r <<= 1;
      $f |= 1 if $_[$i] eq '#';
      $r |= 1 if $_[-1-$i] eq '#';
    }

    push @e, $f, $r;
  };

  $bits->(@{$this->[0]});
  $bits->(@{$this->[-1]});
  $bits->(map { $_->[0] } @$this);
  $bits->(map { $_->[-1] } @$this);

  @e;
}

use overload '""' => sub {
  my ($this) = @_;

  for my $row (@$this)
  {
    print @$row, $/;
  }
};

1;
