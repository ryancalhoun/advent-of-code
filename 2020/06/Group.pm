package Group;

sub new
{
  my $class = shift;
  my $self = {
    _answers => {},
    _members => 0,
  };
  bless $self, $class;
  return $self;
}

sub inc
{
  my $self = shift;
  ++$self->{_answers}->{$_} for @_;
  ++$self->{_members};
}

sub trim
{
  my ($self) = @_;

  my $ans = $self->{_answers};
  for(keys %$ans)
  {
    delete $ans->{$_} unless $ans->{$_} == $self->{_members};
  }
}

sub size
{
  my ($self) = @_;
  scalar %{$self->{_answers}};
}

1;
