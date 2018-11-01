#!/bin/sh
#check the rm function works
legit.pl init
echo line 1 > a
legit.pl add a
legit.pl commit -m "first commit"
echo line 2 >>a 
touch b c 
legit.pl add b c 
legit.pl rm a
legit.pl commit -m "second commit"
legit.pl rm b