#!/usr/bin/perl -w

use File::Copy;


@arr = glob "*.*";

$i=0;
my $dir = $ENV{'PWD'};
while ($i >= 0) {
	$folder = "snapshot$i";
	$i++;
	if (-e "$folder") {
		next;
	}
	else{
		mkdir $folder;
		foreach my $file (@arr) {
		if ($file ne "snapshot.pl") {
			copy("$file", "$dir/$folder" );

			}
		}
		last;	

	}
}