#!/bin/sh
#check the init and add works
legit.pl init
echo "hello" > a
if [[ ! -e .legit ]]; then
	echo -e "legit.pl:Error:there is no .legit directory\n";
fi
legit.pl add a
legit.pl commit -m 'first commit'
echo line 2 >>a
echo world >b
legit.pl add b
legit.pl commit -m 'second commit'
legit.pl show 0:a
legit.pl show 1:b