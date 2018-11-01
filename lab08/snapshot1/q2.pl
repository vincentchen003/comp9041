#!/usr/bin/perl -w
use File::Copy;
if (-e $ARGV[0]) {
	$i = 0 ;
	while ($i >=0) {
		$str = "$ARGV[0].$i";
		$i++;
		unless (-e $str){
			print "$str\n";
			copy( $ARGV[0], $str );
			last
		}
	}
}