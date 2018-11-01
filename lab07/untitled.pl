#!/usr/bin/perl -w
open FILE, "$ARGV[0]";
$sum=0;
while ($line=<FILE>) {

	# body...
	$line = chomp($line);
	$line =~ s/[ . , ? ! ; : ' " ( ) { }  \[ \] *] / /g;
	@word = split(/ /,$line);
	$sum = $sum + @word;
}
print "$sum";
close FILE;
