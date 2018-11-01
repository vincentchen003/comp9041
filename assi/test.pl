#!/usr/bin/perl -w
use Cwd;
$path = getcwd;
	@num = glob "$path/[a-zA-Z0-9]*";
	foreach my $file (@num) {
		$file =~ s/$path\///;
		print "$file\n";
	}