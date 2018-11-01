#!/usr/bin/perl -w
$url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2018/$ARGV[0].html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
	if ($line =~ /.*Prerequisite.*/){
		print "$line";
		while ($line =~m/ [A-Z]{4}[0-9]{4}/){
	$line =~ m/[A-Z]{4}[0-9]{4}/;
	print "$&\n";
	$line = $';}	
}
}
$url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2018/$ARGV[0].html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
	if ($line =~ /.*Prerequisite.*/){
		while ($line =~m/ [A-Z]{4}[0-9]{4}/){
	$line =~ m/[A-Z]{4}[0-9]{4}/;
	print "$&\n";
	$line = $';}	
}
}