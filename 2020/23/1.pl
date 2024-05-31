my @a = (4,1,2,3);

my $i = 0;
++$i until $a[$i] == 1;

print $i, $/;
