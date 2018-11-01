#!/bin/sh
#check the branch function works
legit.pl init
echo line 1 > a
echo line 1 > b
legit.pl add a b 
legit.pl commit -m "first commit"
echo line 2 >>a 
legit.pl branch
legit.pl branch "b1"
legit.pl branch "b2"
legit.pl branch