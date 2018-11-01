#!/usr/bin/perl -w
$filename = "$ARGV[0]";
 open FILE, "$filename";
 while ($line = <FILE>) {
		@words = split(/[^a-zA-Z]/,$line);
		foreach my $word (@words) {
			if ($word){
			if(exists $hash1{$word}){
				$hash1{$word} += 1;
			}
			 else {
				$hash1{$word} = 1;
			}
			}
		}
		
	}
foreach $key (keys %hash1)
{
	print "$key $hash1{$key} \n";
}


$sum = 0;
$sumall =0;
$div = 0;
$dir = "./lyrics";
opendir (DIR, $dir) or die "can't open the directory!";
@dir = readdir DIR;
@dir =  sort { lc($a) cmp lc($b) }@dir;
foreach my $file (@dir) {
	open FILE, "$dir/$file";
	while ($line = <FILE>) {
		@words = split(/[^a-zA-Z]/,$line);
		foreach my $word (@words) {
		if ($word) {
			$sumall++ ;
			if  {
				# body...
			} else {
				# else...
			}
		}
		
	}
}	
	if ($sumall !=0) {
		# body...
	$div = log(($sum + 1) / $sumall);
	$file =~ s/.txt//g;
	printf "log((%d+1)/%6d) = %8.4f %s\n",$sum,$sumall,$div,$file;
	$sum = 0;
	$sumall = 0;
}
	close FILE;
}