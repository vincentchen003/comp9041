%hash1=();
%hash2=();
foreach $file (glob "lyrics/*.txt"){
	$name =~ $file;
	$name =~ s/lyrics\///g;
	$name =~ s/_//g;
	$name =~ s/.txt//g;
	open (FILE,"<","$file");
	while ($line = <F>){
		@words = split(/[^a-zA-Z]/,$line);
		foreach $word(@words){
			if ($word) {
				$hash1{$who}{lc $word} +=1;
				$hash2{$who += 1};
			}
		}
	}
}
foreach $file (glob "@ARGV"){
	@sing = ();
	%hash3 = ();
	open (F,"<","$file");
	while ($line = <F>) {

		# body...
		@words = split(/[^a-zA-Z]/,$line);
		foreach my $word (@words) {
		 	# body...
		 	if ($word){
		 		@sing = (@sing,$word);
		 	}
		 } 
	}
	foreach $art (sort keys %hash2){
		$x=0;
		foreach my $voc (@sing) {

			# body...
			if ($hash1{$art}(lc $voc)){}
			else ($hash1{$art}(lc $voc)=0;)
			$i = log(($hash1{$art}(lc $voc)+1)/ $hash2{$art});
			$x+=$i;
		}
		$hash3{$art} +=$x;
	}
}