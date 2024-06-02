package RuleSet;

sub new
{
  bless {};
}

sub match
{
  my ($this, $message) = @_;
  grep { $_ == length $message } $this->_match([split //, $message], 0, 0);
}

sub _match
{
  my ($this, $message, $i, $id) = @_;
  my $rule = $this->{int $id};

  my @n;
  push @n, $this->_match_seq($message, $i, $_) for @{$rule->{rule}};

  @n;
}

sub _match_seq
{
  my ($this, $message, $i, $seq) = @_;

  my @n = (0);
  for my $sym (@$seq)
  {
    my @m;
    for my $j (@n)
    {
      if(my ($lit) = $sym =~ /"(\w+)"/)
      {
        push @m, $j + length $lit if $message->[$i + $j] eq $lit;
      }
      else
      {
        push @m, $j + $_ for $this->_match($message, $i + $j, $sym);
      }
    }
    @n = @m;
  }

  @n;
}

1;
