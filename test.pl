#!/usr/bin/perl -w
open FILE, "<", "$ARGV[0]";
while ($line = <FILE>) {
	$line = substr($line,12);
	$line =~ s/ {1,}/ /g;
	$line =~ s/^ //;
	$line =~ s/ $//;
	$line =~ s/\n//g;
	$line = lc($line);
	$line =~ s/s$//g;
	unless (grep /$line/,@arr1) {
		push(@arr1,$line);
	}
	
}
@arr1 = sort { lc($a) cmp lc($b) }@arr1;
print("@arr1\n");
close FILE;