package Count;

sub parents
{
  my %parents;
  my @looking = (shift);
  my $rules = shift;

  while(scalar @looking)
  {
    my @next;
    for my $r (keys %$rules)
    {
      my $rule = $rules->{$r};
      for(@looking)
      {
        if(exists($rule->{$_}))
        {
          push @next, $r if ++$parents{$r} == 1;
        }
      }
    }
    @looking = @next;
  }
  scalar keys %parents;
}

sub children
{
  my %children;
  my $top = shift;
  my $rules = shift;

  my @looking = keys %$rules;

  while(@looking)
  {
    my $i = 0;
    while($i < $#looking + 1)
    {
      my $rule = $rules->{$looking[$i]};
      if(grep { not $children{$_} } keys %$rule)
      {
        ++$i;
      }
      else
      {
        my $value = 1;
        $value += $rule->{$_} * $children{$_} for keys %$rule;

        $children{$looking[$i]} = $value;

        splice(@looking, $i, 1);
      }
    }
  }

  $children{$top} - 1;
}

1;
