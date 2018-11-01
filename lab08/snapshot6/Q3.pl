#!/usr/bin/perl -w

use File::Copy;

if ($ARGV[0] eq "save"){
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
		$n = $i-1;
		print "Creating snapshot $n\n";
		last;	

	}
}
}