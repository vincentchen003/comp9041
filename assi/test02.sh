#!/bin/sh
#check the commit -a works
legit.pl init
echo "hello" > a
if [[ ! -e .legit ]]; then
	echo -e "legit.pl:Error:there is no .legit directory\n";
fi
legit.pl add a
legit.pl commit -m 'first commit'
echo line 2 >>a
echo world >b
touch c d e f g
echo line 1 > e 
legit.pl add b
legit.pl commit -a -m 'second commit'
legit.pl show 1:c