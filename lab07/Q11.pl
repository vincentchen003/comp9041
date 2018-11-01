#!/usr/bin/perl -w
$sum = 0;
$sumall =0;
$dir = "./lyrics";
opendir (DIR, $dir) or die "can't open the directory!";
@dir = readdir DIR;
foreach $file(@dir）{
	open FILE, "$file";
while ($line = <STDIN>) {
	@words = split(/[^a-zA-Z]/,$line);
	foreach my $word (@words) {
		if ($word) {
			$sumall++ ;
		}
		if (lc($word) eq $ARGV[0]) {
			$sum +=1;
		}
		# body...
	}
	# body...
}
print "$sum $sumall\n";
close (FILE);
}