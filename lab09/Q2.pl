#!/usr/bin/perl -w
open F, "$ARGV[0]";
while ($line = <F>){
	chomp $line;
	if ($line =~ /\  then/) {
		$line =~ s/then/\{/;
	}
	if ($line =~ /\  else/){
		$line =~ s/else/\} else \{/;
	}
	if ($line =~ /\  fi/) {
		$line =~ s/fi/\}/;
	}
	if ($line =~ /do/) {
		if ($line =~ /done/) {
			$line =~ s/done/\}/;
		}
		else {
			$line =~ s/do/\{/;
		}
		
	}
	if($line =~ /[a-zA-Z]{1,}=/){
		$word = $line;
		$word =~ s/=.*//g;
		$word =~ s/ //g;
		chomp $word;
		$line =~ s/[a-zA-Z]*=/\$$word=/;
		chomp $line;
		$line = $line . ";";
	}
	if ($line =~ m/#!\/bin\/bash/) {
		$line = "#!/usr/bin/perl -w";
	}
	if ($line =~ /\ \(\(/) {
		$func = $line;
		$func =~ s/.*\(\(//;
		$func =~ s/\)//g;
		@arr = split /[ ]/,$func;
		$string = "";
		foreach my $var (@arr) {
			$var =~ s/ //g;
			if ($var=~ m/^[a-zA-Z]/){
				$var = "\$".$var;
			}
			$string = $string." ".$var;
			chomp $string;}
			$string =~ s/ //;
			$line =~ s/\(\(.*/\($string\)/;


	}
	if ($line =~ m/=\$\(\(/) {
		$func = $line;
		$func =~ s/.*\(\(//;
		$func =~ s/\)//g;
		@arr = split /[ ]/,$func;
		$string = "";
		foreach my $var (@arr) {
			$var =~ s/ //g;
			if ($var=~ m/^[a-zA-Z]/){
				$var = "\$".$var;
			}
			$string = $string." ".$var;
		}
			chomp $string;
			$line =~ s/=.*/=$string/;
		


		
	}
	if ($line =~ /echo/){
		$line =~ s/echo /print \"/;
		$line =$line . "\\n\"\;"
	}
	push @finalarr,$line;

}
close F;


foreach my $line (@finalarr) {
	print "$line\n";
}