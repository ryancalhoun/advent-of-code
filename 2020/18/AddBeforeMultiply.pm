package AddBeforeMultiply;

sub evaluate
{
  for(my $i = 1; $i < $#_;)
  {
    if($_[$i] eq '+')
    {
      my $sum = $_[$i-1] + $_[$i+1];
      splice(@_, $i-1, 3, $sum);
    }
    elsif($_[$i] eq '*')
    {
      splice(@_, $i++, 1);
    }
  }

  my $prod = 1;
  $prod *= $_ for @_;

  $prod;
}

1;
