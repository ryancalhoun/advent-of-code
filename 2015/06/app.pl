print "A = zeros(1000);$/";

my $action = {
  'toggle' => sub { "$_[0] = !$_[0];" },
  'turn on' => sub { "$_[0] = 1;" },
  'turn off' => sub { "$_[0] = 0;" },
  'total' => sub { "sum(A(:) == 1)" }
};

if($ENV{PART} == 2) {
  $action = {
    'toggle' => sub { "$_[0] += 2;" },
    'turn on' => sub { "$_[0] += 1;" },
    'turn off' => sub { "x = $_[0]; x(x > 0) -= 1; $_[0] = x;" },
    'total' => sub { "sum(A(:))" }
  };
}

while(<>) {
  my ($act,$r0,$c0,$r1,$c1) = /(toggle|turn off|turn on) (\d+),(\d+) through (\d+),(\d+)/;
  my $range = sprintf "A(%d:%d,%d:%d)", $r0+1, $r1+1, $c0+1, $c1+1;

  print $action->{$act}->($range), $/;

}

printf "printf(\"%%d\\n\", %s);$/", $action->{total}->();
