#!/usr/bin/perl -w



 
if($#ARGV!=1){
	my $usage = <<USAGE;
Usage: ./echon.pl <number of lines> <string> 
USAGE
	print "$usage"
	}
else{
	$ARG1 = $ARGV[0];
	$ARG2 = $ARGV[1];
	if ($ARG1 >= 0 and $ARG1 =~ /^\d+$/) {
		for (my $i = 0; $i < $ARG1; $i++){
			print "$ARG2\n"
		}
	} else {
		print "./echon.pl: argument 1 must be a non-negative integer\n"
	}
 }
