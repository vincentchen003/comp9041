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
			if (exists $hash2{$word}) {
				$hash2{$word} += $hash1{$word};

			} else {
				$hash2{$word} = $hash1{$word};
			}
		}
		
	}
}	
	if ($sumall !=0) {
	$sumall = 0;
}
	foreach $key (keys %hash2)
{
	print "$key $hash2{$key} \n";
} 
	close FILE;
	
}