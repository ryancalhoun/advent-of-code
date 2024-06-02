package Hex;

sub new
{
  bless {}
}

sub follow_path
{
  my $this = shift;
  my ($x,$y) = (0, 0);

  my %move = (
    w  => sub { $x -= 2 },
    e  => sub { $x += 2 },
    se => sub { $x += 1; $y -= 1 },
    sw => sub { $x -= 1; $y -= 1 },
    ne => sub { $x += 1; $y += 1 },
    nw => sub { $x -= 1; $y += 1 },
  );

  $move{$_}->() for @_;

  $this->{&_key($x, $y)} = !$this->{&_key($x, $y)};
}

sub play_go
{
  my $this = shift;

  my %neighbors;
  while(my ($k,$v) = each %{$this})
  {
    next unless $v;
    my ($x,$y) = split ',', $k;

    my @neighbors = (
      &_key($x-2, $y),
      &_key($x+2, $y),
      &_key($x+1, $y-1),
      &_key($x+1, $y+1),
      &_key($x-1, $y-1),
      &_key($x-1, $y+1),
    );

    ++$neighbors{$_} for @neighbors;
  }

  my %next;
  while(my ($k,$n) = each %neighbors)
  {
    $next{$k} = 1 if $this->{$k} ? ($n == 1 || $n == 2) : $n == 2;
  }

  %$this = %next;
}

sub count
{
  my $this = shift;

  scalar grep { $_ } values %{$this};
}

sub _key
{
  join ',', @_;
}

1;
