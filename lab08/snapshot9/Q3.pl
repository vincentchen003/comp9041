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
if ($ARGV[0] eq "load"){
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
$dir1 = "$dir/snapshot$ARGV[1]";
opendir (DIR,$dir1);
@dir1 = readdir DIR;
foreach my $file (@dir1) {
	copy("$dir/snapshot$ARGV[1]/$file","$dir/$file");
}
print "Restoring snapshot $ARGV[1]";


}
