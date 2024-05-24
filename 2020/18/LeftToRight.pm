package LeftToRight;

sub evaluate
{
  my $r = shift;

  while(@_)
  {
    my $op = shift;
    if($op eq '+')
    {
      $r += shift;
    }
    elsif($op eq '*')
    {
      $r *= shift;
    }
  }
  $r;
}

1;
