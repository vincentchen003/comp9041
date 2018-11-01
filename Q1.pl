#!/usr/bin/perl -w
open FILE, "<", "$ARGV[0]";
$sum = 0;
while ($line = <FILE>) {
	if ($line =~ /.*orca.*/i) {
		$line = substr($line,9,2);
		$line =~ s/ //g;
		$sum += $line;
	}

}
print "$sum Orcas reported in $ARGV[0]\n";

close FILE;