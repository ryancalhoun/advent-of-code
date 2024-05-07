package Trajectory;

sub new
{
  my $class = shift;
  my $self = {
    slope => shift,
    position => 0,
    trees => 0,
  };
  bless $self, $class;
  return $self;
}
sub check
{
  my $self = shift;
  my $trees = shift;

  return if int($self->{position}) != $self->{position};

  ++$self->{trees} if $$trees[$self->{position} % scalar(@$trees)] eq '#';
}
sub increment
{
  my $self = shift;
  $self->{position} += $self->{slope};
}
sub hit
{
  return shift->{trees};
}

1;

