package Rule;

sub new
{
  my ($class, $rule) = @_;

  bless {
    rule => [map { [split ' '] } split /\|/, $rule]
  }
}

sub add
{
  my ($this, @seq) = @_;
  push @{$this->{rule}}, [@seq];
}

1;
