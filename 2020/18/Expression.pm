use feature qw/current_sub/;

package Expression;

sub new
{
  my ($class, $eval) = @_;
  bless { eval => $eval };
}

sub evaluate
{
  my ($this, $expr) = @_;

  my @token = $expr =~ m/\d+|\S/g;
  my @stack = ([]);

  for(@token)
  {
    if($_ eq '(')
    {
      push @stack, [];
    }
    elsif($_ eq ')')
    {
      my $r = pop @stack;
      push @{$stack[-1]}, $this->{eval}->(@$r);
    }
    else
    {
      push @{$stack[-1]}, $_;
    }
  }

  $this->{eval}->(@{$stack[0]});
}

1;
