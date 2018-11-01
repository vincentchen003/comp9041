#!/usr/bin/perl -w
%hash1 = ();
 $filename = "$ARGV[0]";
 open FILE, "$filename";
 while ($line = <FILE>) {
		@words = split(/[^a-zA-Z]/,$line);
		foreach my $word (@words) {
			if ($word){
			if(exists $hash1{$word}){
				$hash1{lc $word} += 1;
			}
			 else {
				$hash1{lc $word} = 1;
			}
			}
		}
		
	}
@k = keys %hash1;
$kk = @k;
foreach $key (keys %hash1)
{
	print "$key $kk $hash1{$key} \n";
}
close FILE;

$sumall = 0;
$dir = "./lyrics";
opendir (DIR, $dir) or die "can't open the directory!";
@dir = readdir DIR;
@dir =  sort { lc($a) cmp lc($b) }@dir;
%hash2 = ();
 %hash3 = ();
foreach my $file (@dir) {
	$sumall = 0;
	open FILE, "$dir/$file";
	while ($line = <FILE>) {
		@words = split(/[^a-zA-Z]/,$line);
		foreach my $word (@words) {
			if ($word){
				$sumall +=1;
 				if (exists $hash1{lc $word} ){
 					if (exists $hash2{lc $word}) {
 						$hash2{lc $word} += $hash1{lc $word};
 					} 
 					else {
 						$hash2{lc $word} = $hash1{lc $word};
 					}
				
				}				

 			}
 	}
 	

 }


 	$answer = 0;
 	foreach $key (keys %hash1){
 		unless (exists $hash2{$key}) {
 			$hash2{$key} = 0;
 		}
 	}
 	if($sumall != 0){
 	foreach $key (keys %hash2)
	{
		$cal = log(($hash2{$key} + 1)/ $sumall);
		$answer += $cal;
	}
	$answer = sprintf "%.1f",$answer;
	$hash3{$file} = $answer;
	
	}
	
 	close FILE;
 	%hash2 =();
}
@name = keys %hash3;
	$outname = $name[0];
	$outvalue = $hash3{$name[0]};
foreach $key (keys %hash3) {
		if ($hash3{$key} > $outvalue) {
			$outvalue = $hash3{$key};
			$outname = $key;
		}
		# body...
	}
$outname =~ s/\.txt//g;
$outname =~ s/_/ /g; 
print "$outname $outvalue\n";
# foreach $key (keys %hash1)
# {
# 	print "$key $hash{$key} \n";
# }
# close FILE;
# %hash2 =();
# }



