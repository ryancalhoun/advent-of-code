package Circle;

sub new
{
  bless [];
}

sub push
{
  my $this = shift;
  push @$this, @_;
}

sub size
{
  my ($this) = @_;
  scalar @$this;
}

sub index_of
{
  my ($this, $v) = @_;

  for(my $i = 0; $i < $this->size; ++$i)
  {
    return $i if $this->[$i] == $v;
  }

  return -1;
}

sub move
{
  my ($this) = @_;

  my ($current, @picked_up) = splice @$this, 0, 4;

  my $target = $current;
  my $i = -1;

  until($i != -1)
  {
    $target = 10 if $target < 1;
    --$target;
    $i = $this->index_of($target);
  }

  splice @$this, $i+1, 0, @picked_up;
  push @$this, $current;
}

sub final
{
  my ($this) = @_;
  my $i = $this->index_of(1);

  (@$this[$i+1..$this->size - 1], @$this[0..$i-1]);
}

use overload '""' => sub {
  my ($this) = @_;

  join ' ', @$this;
};

1;
