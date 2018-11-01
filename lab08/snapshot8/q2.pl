#!/usr/bin/perl -w
use File::Copy;
# if (-e $ARGV[0]) {
# 	$i = 0 ;
# 	while ($i >=0) {
# 		$str = ".$ARGV[0].$i";
# 		$i++;
# 		unless (-e $str){
# 			print "Backup of '$ARGV[0]' saved as '$str'\n";
# 			copy( $ARGV[0], $str );
# 			last
# 		}
# 	}
# }
copy ("1.txt","2.txt");