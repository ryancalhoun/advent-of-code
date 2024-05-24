use feature qw/current_sub/;
use experimental qw/smartmatch/;

package Grid;

sub new
{
  bless {};
}

sub set
{
  my ($this,@c) = @_;
  $this->{join ',', @c} = 1;
}

sub count
{
  my ($this) = @_;
  scalar keys %$this;
}

sub cycle
{
  my ($this) = @_;

  my %c;
  for my $k (keys %$this)
  {
    ++$c{join ',', @$_} for $this->neighbors($k);
  }

  my $next = {};
  while(my ($k,$v) = each %c)
  {
    $next->{$k} = 1 if $this->{$k} ? $v == 2 || $v == 3 : $v == 3;
  }

  %$this = %$next;
}

sub neighbors
{
  my ($this,$k) = @_;

  my @c = split ',', $k;
  my @n;

  sub {
    my ($i,@c1) = @_;

    if($i == scalar @c)
    {
      push @n, [@c1] unless @c1 ~~ @c;
      return;
    }
    for($c[$i]-1..$c[$i]+1)
    {
      $c1[$i] = $_;
      __SUB__->($i+1, @c1);
    }
  }->(0, @c);

  @n;
}

1;
