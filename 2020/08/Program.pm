package Program;

my %operations = (
  nop => sub {
    my ($arg, $ptr, $reg) = @_;
    ++$$ptr;
  },
  acc => sub {
    my ($arg, $ptr, $reg) = @_;
    $$reg += $arg;
    ++$$ptr;
  },
  jmp => sub {
    my ($arg, $ptr, $reg) = @_;
    $$ptr += $arg;
  },
);

sub run
{

  my $ptr = 0;
  my $reg = 0;

  my %called;

  while($ptr <= $#_)
  {
    die $reg . $/ if(++$called{$ptr} > 1);
    my ($op, $arg) = @{$_[$ptr]};
    $operations{$op}->($arg, \$ptr, \$reg);
  }
  $reg;
}

1;
