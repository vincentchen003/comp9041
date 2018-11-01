#!/usr/bin/perl -w
use File::Copy;
use Cwd;
#########initialize the repo#########
if (@ARGV==1 and $ARGV[0] eq "init") {
	if (-e ".legit") {
		print "legit.pl: error: .legit already exists\n";
	}
	else{
		mkdir ".legit";
		print "Initialized empty legit repository in .legit\n";
	}
}
##########
###########Add function####################
if ($ARGV[0] eq "add") {
	unless (-e ".legit") {
		print "legit.pl: error: no .legit directory containing legit repository exists\n";
	}
	else {
	unless (-e ".legit/index") {
		mkdir ".legit/index"
	}
	my $path = getcwd;
	@arr = @ARGV;
	splice @arr,0,1;
	foreach my $var (@arr) {
		if (-e $var) {
			copy($var,"$path/.legit/index"); 
		}
		else{
			if (-e "$path/.legit/index/$var") {
				unlink "$path/.legit/index/$var";
			}
			else{
			print "legit.pl: error: can not open '$var'\n";
		}
		}
	}
}
}
###########
##############commit function############
if ($ARGV[0] eq "commit") {
	# body...
	$text = "";
	my $path = getcwd;
	###creat file to store the commit information######
	unless (-e ".legit/commit.txt") {
		open F, ">commit.txt";
		close F;
		copy("commit.txt","$path/.legit");
		unlink "commit.txt";

	}
	###creat directory of commit######
	unless (-e ".legit/commit") {
		mkdir ".legit/commit";
	
	}
	opendir DIR, ".legit/commit";
	@list = readdir DIR;
	closedir DIR;
	$num = @list;
	$num = $num - 2;

	#####situation -a######
	if ($ARGV[1] eq "-a") {
		opendir DIR, ".legit/index";
		@list = readdir "DIR";
		close DIR;
		foreach my $file (@list) {
			if (-f $file) {
				copy($file,"$path/.legit/index");
			}
		}

	}

######decide if there is at least one commit########	
	if ($num > 0) {
		$boolen = 0;
		opendir D, "$path/.legit/index";
		@arr1 = readdir D;
		@arr1 = @arr1[2..@arr1-1];
		close D;
		$previous = $num - 1;
		opendir D,"$path/.legit/commit/$previous";
		@arr2 = readdir D;
		@arr2 = @arr2[2..@arr2-1];
		close D;
		if (@arr1 != @arr2){
			$boolen = 1;
		}
		else {
			for (my $i = 0; $i < @arr1; $i++) {
				if ($arr1[$i] ne $arr2[$i]) {
					$boolen = 1;
					last;
				}
				else {
					if (-e "$path/.legit/index/$arr1[$i]" and -e "$path/.legit/commit/$previous/$arr1[$i]"){ 
					open F, "$path/.legit/index/$arr1[$i]";
					@line1 = <F>;
					close F;
					open F, "$path/.legit/commit/$previous/$arr1[$i]";
					@line2 = <F>;
					close F;
					if (@line1 != @line2) {
						$boolen = 1;
						last;
					}
					else {
						for (my $n = 0; $n < @line1; $n++) {
							if ($line1[$n] ne $line2[$n]) {
								$boolen = 1;
								last;
							}
						}
						if ($boolen == 1) {
							last;
						}
					}
				}

				}
			}
		}
		print "nothing to commit\n" if $boolen ==0;
		exit if $boolen == 0;

	}
#############situation second arugment in command line is -m #####
	if ($ARGV[1] eq "-m")
	{
		mkdir ".legit/commit/$num";
		opendir DIR, ".legit/index";
		@list1 = readdir DIR;
		close DIR;
		foreach my $file (@list1) {
			if ($file =~ m/^[a-zA-Z0-9]*/) {
				copy("$path/.legit/index/$file","$path/.legit/commit/$num");
			}
		$text = $ARGV[2];
	}
	}
#############situation second arugment in command line is -a #####
	if ($ARGV[1] eq "-a") {
		mkdir ".legit/commit/$num";
		opendir DIR, ".legit/index";
		@list = readdir "DIR";
		close DIR;
		foreach my $file (@list) {
			if (-f $file) {
				copy($file,"$path/.legit/index");
				copy($file,"$path/.legit/commit/$num");
			}
		}
		$text = $ARGV[3];
	}
	print "Committed as commit $num\n";
	open F, "<.legit/commit.txt";
	while ($line = <F>) {
		push @arr,$line;
	}
	close F;
	open F, ">.legit/commit.txt";
	print F "$num $text\n";

	foreach my $line (@arr) {
		print F "$line";
	}

	close F;
}
######## log function ######
if ($ARGV[0] eq "log") {
	$path = getcwd;
	$arr = "$path/.legit/commit.txt";
	open F,"$arr";
	while ($line = <F>) {
		# body...
		print "$line";
	}
	close F;
}
######## show function ######
if ($ARGV[0] eq "show") {
	$path = getcwd;
	@arr = split /:/,$ARGV[1];
	if ($arr[0] ne ""){
		unless (-e "$path/.legit/commit/$arr[0]") {
			print "legit.pl: error: unknown commit '$arr[0]'\n";
		}
		else {
			unless (-e "$path/.legit/commit/$arr[0]/$arr[1]") {
				print "legit.pl: error: '$arr[1]' not found in commit $arr[0]\n";
			}
			else{
			$file = "$path/.legit/commit/$arr[0]/$arr[1]";
			open F, "$file";
			while ($line = <F>) {
				print "$line";

			}
			close F;
		}
	}	
	}
	else {
		$file = "$path/.legit/index/$arr[1]";
		if (-e $file) {
		open F , "$file";
		while ($line = <F>) {
		print "$line";
		}
	}
		else {
			print "legit.pl: error: '$arr[1]' not found in index\n";
		}
	}
	close F;

	}

###### rm function ############
if ($ARGV[0] eq "rm") {
	$path = getcwd;
	if (@ARGV > 3) {
		if (($ARGV[1] eq "--cached" and $ARGV[2] eq "--force") or($ARGV[2] eq "--cached" and $ARGV[1] eq "--force")) {
			foreach my $file (@ARGV[3..@ARGV-1]) {
				if (-e "$path/.legit/index/$file") {
					unlink "$path/.legit/index/$file";
				}
			
			}
			exit;
		}
	}
##################cached function####################
	if ($ARGV[1] eq "--cached") {
		@list = @ARGV[2..@ARGV-1];
		foreach my $file (@list) {
		##########define and creat the array#########
		@arrnow = ();
		@arrindex = ();
		@arrcommit = ();
		if (-e "$file") {
			open F, "$file";
			while ($line = <F>) {
				push @arrnow, $line
			}
			close F;
	}
		$dirindex = "$path/.legit/index/$file";
		if (-e $dirindex) {
			open F,$dirindex;
			while ($line = <F>) {
				push @arrindex,$line;
			}
			close F;
	}
		@num = glob "$path/.legit/commit/[0-9]*";
		$num = @num - 1;
		$dircommit = "$path/.legit/commit/$num/$file";
		if (-e $dircommit){
			open F,$dircommit;
			while ($line = <F>) {
				push @arrcommit, $line;
			}
			close F;
	}
		#############################################
		$boolIN = 0;
		$boolCOM = 0;
		$boolINCOM = 0;
		if (@arrnow != @arrcommit) {
			$boolCOM = 1;
		}
		else{
			for (my $i = 0; $i < @arrnow; $i++) {
				if ($arrnow[$i] ne $arrcommit[$i]) {
					$boolCOM = 1;
					last;
				}
			}
		}
		if (@arrindex != @arrcommit) {
			$boolIN = 1;

		}
		else {
			for (my $i = 0; $i < @arrindex; $i++){
				if ($arrindex[$i] ne $arrcommit[$i]){
					$boolIN = 1;
					last;
				}
			}
		}
		if (@arrindex != @arrnow) {
				$boolINCOM = 1;

			}
		else {
				for (my $i = 0; $i < @arrindex; $i++){
					if ($arrindex[$i] ne $arrnow[$i]){
						$boolINCOM = 1;
						last;
					}
				}
			}
##########situations####################
			if (! -e "$path/.legit/index/$file") {
				print "legit.pl: error: '$file' is not in the legit repository\n";
				next;
			}
			if ($boolIN ==1 and $boolINCOM == 1) {
				print "legit.pl: error: '$file' in index is different to both working file and repository\n";
				next;
			}
			unlink "$dirindex";
		}
	}
######################force function##################
	elsif ($ARGV[1] eq "--force") {
		@list = @ARGV[2..@ARGV-1];
		foreach my $file (@list) {
			if (! -e "$path/.legit/index/$file") {
				print "legit.pl: error: '$file' is not in the legit repository\n";
				next;
			}
			unlink "$path/.legit/index/$file";
			unlink "$path/$file";
		}

		
	}
#######################Ordinary function#############
	else {
		@list = @ARGV[1..@ARGV-1];
		foreach my $file (@list) {
		
		##########define and creat the array#########
		@arrnow = ();
		@arrindex = ();
		@arrcommit = ();
		if (-e "$file") {
			open F, "$file";
			while ($line = <F>) {
				push @arrnow, $line
			}
			close F;
	}
		$dirindex = "$path/.legit/index/$file";
		if (-e $dirindex) {
			open F,$dirindex;
			while ($line = <F>) {
				push @arrindex,$line;
			}
			close F;
	}
		@num = glob "$path/.legit/commit/[0-9]*";
		$num = @num - 1;
		$dircommit = "$path/.legit/commit/$num/$file";
		if (-e $dircommit){
			open F,$dircommit;
			while ($line = <F>) {
				push @arrcommit, $line;
			}
			close F;
	}
		######different situation#######
		if (-e $file and ! -e $dirindex and ! -e $dircommit) {
			print "legit.pl: error: '$file' is not in the legit repository\n";
			next;
		}
		#############################################
		$boolIN = 0;
		$boolCOM = 0;
		$boolINCOM = 0;
		if (@arrnow != @arrcommit) {
			$boolCOM = 1;
		}
		else{
			for (my $i = 0; $i < @arrnow; $i++) {
				if ($arrnow[$i] ne $arrcommit[$i]) {
					$boolCOM = 1;
					last;
				}
			}
		}
		if (@arrindex != @arrcommit) {
			$boolIN = 1;

		}
		else {
			for (my $i = 0; $i < @arrindex; $i++){
				if ($arrindex[$i] ne $arrcommit[$i]){
					$boolIN = 1;
					last;
				}
			}
		}
		if (@arrindex != @arrnow) {
				$boolINCOM = 1;

			}
		else {
				for (my $i = 0; $i < @arrindex; $i++){
					if ($arrindex[$i] ne $arrnow[$i]){
						$boolINCOM = 1;
						last;
					}
				}
			}
##########situations####################
		if ($boolIN == 0 and $boolCOM == 1) {
			print "legit.pl: error: '$file' in repository is different to working file\n";
			next;
		}
		if ($boolCOM == 1 and $boolINCOM == 1 and $boolIN == 1){
			print "legit.pl: error: '$file' in index is different to both working file and repository\n";
			next;
		}
		if ($boolINCOM == 0 and (! -e $dircommit or $boolIN == 1)) {
			print "legit.pl: error: '$file' has changes staged in the index\n";
			next;
		}
		if ($boolIN == 0 and $boolCOM == 0) {
			unlink "$path/.legit/index/$file";
			unlink "$file";
		}

	}
}
	
}


###### status function ###########
if ($ARGV[0] eq "status") {
	$path = getcwd;
	@num = glob "$path/.legit/commit/[0-9]*";
	$num = @num - 1;
	##find the files of original directory
	opendir DIR,".";
	@arr = readdir DIR;
	close DIR;
	@arrfile = ();
	foreach my $var (@arr) {
		if (-f $var){
			push @arrfile, $var;
		}
	}
	opendir DIR, "$path/.legit/index";
	@arr = readdir DIR;
	push @arrfile,@arr;
	close DIR;
	opendir DIR, "$path/.legit/commit/$num";
	@arr = readdir DIR;
	push @arrfile,@arr;
	close DIR;
	%count = ();
	@arrfile = grep { ++$count{ $_ } < 2; } @arrfile;
	@arrfile = sort @arrfile;
	splice @arrfile,0,2;
	###
	foreach my $file (@arrfile) {
		if (-e "$path/.legit/index/$file" and -e "$path/.legit/commit/$num/$file" and ! -e "$file") {
			print "$file - file deleted\n"
		}
		
		if (! -e "$path/.legit/index/$file" and -e "$path/.legit/commit/$num/$file" and ! -e "$file") {
			print "$file - deleted\n"
		}
	
		if (-e "$path/.legit/index/$file" and ! -e "$path/.legit/commit/$num/$file" and -e "$file") {
			print "$file - added to index\n"
		}
		
		if (! -e "$path/.legit/index/$file" and  -e "$file") {
			print "$file - untracked\n"
		}
		if ( -e "$path/.legit/index/$file" and -e "$path/.legit/commit/$num/$file" and -e "$file") {
			###convert file into array
			@arrnow = ();
			@arrindex = ();
			@arrcommit = ();
			open F, "$file";
			while ($line = <F>) {
				push @arrnow, $line
			}
			close F;
			$dirindex = "$path/.legit/index/$file";
			open F,$dirindex;
			while ($line = <F>) {
				push @arrindex,$line;
			}
			close F;
			@num = glob "$path/.legit/commit/[0-9]*";
			$num = @num - 1;
			$dircommit = "$path/.legit/commit/$num/$file";
			open F,$dircommit;
			while ($line = <F>) {
				push @arrcommit, $line;
			}
			close F;
			###
			$boolIN = 0;
			$boolCOM = 0;
			$boolINCOM = 0;
			if (@arrnow != @arrcommit) {
				$boolCOM = 1;
			}
			else{
				for (my $i = 0; $i < @arrnow; $i++) {
					if ($arrnow[$i] ne $arrcommit[$i]) {
						$boolCOM = 1;
						last;
					}
				}
			}
			if (@arrindex != @arrcommit) {
				$boolIN = 1;

			}
			else {
				for (my $i = 0; $i < @arrindex; $i++){
					if ($arrindex[$i] ne $arrcommit[$i]){
						$boolIN = 1;
						last;

					}
				}
			}
			if (@arrindex != @arrnow) {
				$boolINCOM = 1;

			}
			else {
				for (my $i = 0; $i < @arrindex; $i++){
					if ($arrindex[$i] ne $arrnow[$i]){
						$boolINCOM = 1;
						last;
					}
				}
			}
			if ($boolIN == 0 and $boolINCOM ==0 and $boolCOM == 0) {
				print "$file - same as repo\n";
			}
			if ($boolIN == 1 and $boolINCOM == 1 and $boolCOM == 1) {
				print "$file - file changed, different changes staged for commit\n";
			}
			if ($boolIN == 1 and $boolINCOM == 0 and $boolCOM == 1) {
				print "$file - file changed, changes staged for commit\n";
			}
			if ($boolIN == 0 and $boolINCOM == 1 and $boolCOM == 1) {
				print "$file - file changed, changes not staged for commit\n";
			}

		}
}
}

##### store branch infomation #####
if ($ARGV[0] eq "branch") {
	%branch = ();
	$path = getcwd;
	@num = glob "$path/.legit/commit/[0-9]*";
	$num = @num;
	if ($num == 0) {
		print "legit.pl: error: your repository does not have any commits yet\n";
		exit;
	}
	if (@ARGV > 1 and $ARGV[1] eq "master") {
		print "legit.pl: error: branch 'master' already exists\n";
		exit;
	}
	unless (-e "$path/.legit/branch.txt") {
		open F, "> $path/.legit/branch.txt";
		print F"master -1\n";
		close F;
		mkdir "$path/.legit/master";
		mkdir "$path/.legit/master/index";
	}
	unless (-e "$path/.legit/currentbranch.txt") {
		open F, "> $path/.legit/currentbranch.txt";
		print F "master\n";
		close F;
	}
	
		open F, "< $path/.legit/branch.txt";
		while ($line = <F>) {
			chomp($line);
			@elements = split/ /,$line;
			$branch{$elements[0]} = $elements[1];
		}
		close F;
	if (@ARGV == 1){
		@list = ();
		open F, "< $path/.legit/branch.txt";
		while ($line = <F>) {
			chomp($line);
			@arr = split/ /,$line;
			push @list,$arr[0];
		}
		@arr1 = @list[1..@list-1];
		foreach my $var (@arr1) {
			print "$var\n";
		}
		print "$list[0]\n";
	}
	
	if (@ARGV > 1 and $ARGV[1] ne "-d") {
		open F, ">> $path/.legit/branch.txt";
		print F "$ARGV[1] -1\n";
		close F;
		mkdir "$path/.legit/$ARGV[1]";
		mkdir "$path/.legit/$ARGV[1]/index";
		@list = glob "$path/.legit/index/[a-zA-Z0-9]*";
		@list1 = glob "$path/[a-zA-Z0-9]*";
		foreach my $file  (@list) {
			copy($file,"$path/.legit/$ARGV[1]/index");
		}
		foreach my $file (@list1){
			copy($file,"$path/.legit/$ARGV[1]");
		}

	}
######## delete branch #######
	if (@ARGV > 1 and $ARGV[1] eq "-d") {
		@arr = ();
		if ($ARGV[2] eq "master") {
			print "legit.pl: error: can not delete branch 'master'\n";
			exit;
		}
		$bool = 0;
		open F, "< $path/.legit/branch.txt";
		while ($line = <F>) {
			chomp $line;
			push @arr,$line;
			@first = split/ /,$line;
			$first = $first[0];
			$bool = 1 if $first =~ m/$ARGV[2]/;
		}
		if ($bool == 0) {
			print "legit.pl: error: branch '$ARGV[2]' does not exist\n";
			exit;
		}
		close F;
		open F, "> $path/.legit/branch.txt";
		foreach my $line (@arr) {
			unless ($line =~ /^$ARGV[2] -*[0-9]*/){
				print F "$line\n";
			}
		}
		close F;
		print "Deleted branch '$ARGV[2]'\n";
	}
}

########## branch checkout ##########

if ($ARGV[0] eq "checkout") {
	$path = getcwd;
	open F, "< $path/.legit/currentbranch.txt";
	@arr = <F>;
	$checkbranch = $arr[0];
	chomp ($checkbranch);
 	close F;
	open F, "> $path/.legit/currentbranch.txt";
	print F "$ARGV[1]\n";
	close F;

	open F,"< $path/.legit/branch.txt";
	$boolen = 0;
	while ($line = <F>) {
		@arr = split / /, $line;
		if ($ARGV[1]=~ m/$arr[0]/) {
			$boolen = 1;
		}

	}
	if ($boolen == 0) {
		print "legit.pl: error: unknown branch '$ARGV[1]'\n";
		exit;
	}


	@list = glob "$path/.legit/index/[a-zA-Z0-9]*";
	@list1 = glob "$path/[a-zA-Z0-9]*";
	@list2 = glob "$path/.legit/$ARGV[1]/[a-zA-Z0-9]*";
	@list4 = glob "$path/.legit/$ARGV[1]/index/[a-zA-Z0-9]*";
	foreach my $file (@list) {
	 	copy($file,"$path/.legit/$checkbranch/index");
	 	unlink ($file);
	 }
	 foreach my $file (@list1) {
	 	unless ($file =~ m/.*\/legit\.pl/)
	 	{
	  		copy ($file,"$path/.legit/$checkbranch");
	  		unlink ($file);
	  	}
	  }
	 foreach my $file (@list2) {
	 	copy ($file,"$path");
	 	unlink ($file);
	  } 
	  foreach my $file (@list4) {
	  	copy ($file,"$path/.legit/index");
	  	unlink ($file);
	  }

	print "Switched to branch '$ARGV[1]'\n";

}







