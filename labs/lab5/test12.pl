#!/usr/bin/perl -w

@array=();
while(defined (my $line = <>))
  {
     chomp($line);
     push(@array,$line);
  }
 $len = @array;
if ($len>10) {
	for( $a = $len-10; $a < $len; $a = $a + 1 ){
    print "$array[$a]\n";
}
} 
else {
	for( $a = 0; $a < $len; $a = $a + 1 ){
    print "$array[$a]\n";}
}
