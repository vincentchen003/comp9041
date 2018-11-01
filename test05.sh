#!/bin/sh
#check the rm function works
legit.pl init
echo line 1 > a
legit.pl add a
legit.pl commit -m "first commit"
echo line 2 >>a 
touch b c 
legit.pl add a b c 
echo line 1 > b
echo line 1 > c
echo line 3 >> a 
legit.pl --cached a
legit.pl --force --cached a
legit.pl commit -m "second commit"
legit.pl show 1:a