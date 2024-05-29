package RuleSet;

sub new
{
  bless {};
}

sub match
{
  my ($this, $message) = @_;

  $message = [split //, $message] unless ref($message);

  my $n = $this->_match($message, 0, 0);

  $n == scalar @$message;
}

sub _match
{
  my ($this, $message, $i, $id) = @_;

  my $rule = $this->{int $id};

  my @n;

  for my $altern (@{$rule->{rule}})
  {
    my $n = $this->_match_seq($message, $i, $altern);
    push @n, $n if $n;
  }

  return 0 unless @n;

  return (sort { my ($a,$b) = @_; $a <=> $b } @n)[0];
}

sub _match_seq
{
  my ($this, $message, $i, $seq) = @_;

  my $n = 0;

  for my $sym (@$seq)
  {
    if(my ($lit) = $sym =~ /"(\w+)"/)
    {
      return 0 unless $message->[$i + $n] eq $lit;
      $n += length $lit;
    }
    else
    {
      my $m = $this->_match($message, $i + $n, $sym);
      return 0 unless $m;

      $n += $m;
    }
  }

  $n;
}


1;
