#!/usr/bin/perl -w
open FILE, "<", "$ARGV[1]";
$sum = 0;
$i=0;
while ($line = <FILE>) {
	if ($line =~ m/.*$ARGV[0].*/i) {
		$line = substr($line,9,2);
		$line =~ s/ //g;
		$sum += $line;
		$i+=1;
	}

}
print "$ARGV[0] observations: $i pods, $sum individuals\n";

close FILE;