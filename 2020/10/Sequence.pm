package Sequence;

sub new
{
  bless {
    bucket => {},
    lastval => 0,
    lastdiff => 0,
    consec => 0,
    combinations => 1,
  };
}

sub push
{
  my ($self, $val) = @_;

  my $diff = $val - $self->{lastval};

  ++$self->{bucket}->{$diff};

  if($diff == $self->{lastdiff})
  {
    ++$self->{consec};
  }
  else
  {
    if($self->{lastdiff} == 1)
    {
      $self->{combinations} *= 2 if $self->{consec} == 1;
      $self->{combinations} *= 4 if $self->{consec} == 2;
      $self->{combinations} *= 7 if $self->{consec} == 3;
    }
    $self->{consec} = 0;
  }

  $self->{lastval} = $val;
  $self->{lastdiff} = $diff;
}

sub bucket
{
  my ($self, $diff) = @_;
  $self->{bucket}->{$diff};
}

sub combinations
{
  my ($self) = @_;
  $self->{combinations};
}

1;
