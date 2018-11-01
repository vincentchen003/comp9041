#!/usr/bin/perl -w

$sum=0;
while ($line=<>) {

	# body..
	@word = split(/[^a-zA-Z]/,$line);
	foreach $str (@word) {
		if ($str ne "") {
			
			$sum = $sum +1;
		}
	}
}
print "$sum\n";
