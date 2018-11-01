#！/user/bin/perl -w
while (defined($string = <STDIN>)) {
	
	$string =~ tr/[0-4]/</;
	$string =~ tr/[6-9]/>/;
	
	print "$string";
}

	