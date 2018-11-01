#!/usr/bin/perl -w
open FILE, "<", "$ARGV[0]";
while ($line = <FILE>) {
	$line = lc(substr($line,12));
	$line =~ s/ {1,}/ /g;
	$line =~ s/^ //;
	$line =~ s/ $//;
	$line =~ s/\n//g;
	$line = lc($line);
	$line =~ s/s$//g;
	unless (grep /$line/, @array) {
		push(@array,$line)
	}

}
@array = sort { lc($a) cmp lc($b) }@array;
close FILE;
foreach $var (@array) {
	open FILE, "<", "$ARGV[0]";
	$sum = 0;
	$i=0;
while ($line = <FILE>) {
	$line =~ s/ {1,}/ /g;
	$line =~ s/^ //;
	$line =~ s/ $//;
	$line =~ s/\n//g;
	$line = lc($line);
	$line =~ s/s$//g;
	if ($line =~ m/[0-9] $var.*/i) {
		$line = substr($line,9,2);
		$line =~ s/ //g;
		$sum += $line;
		$i+=1;
	}
	

}
$var =~ s/\n//g;
print("$var observations: $i pods, $sum individuals\n");

close FILE;

	
}


