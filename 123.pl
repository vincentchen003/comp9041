#!/usr/bin/perl -w
open FILE, "<", "$ARGV[0]";
while ($line = <FILE>) {
	if ($line =~ m/bottlenose/) {
		print "$line";
	}
}
close FILE;