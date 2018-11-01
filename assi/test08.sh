#!/bin/sh
#check the combination of branch and checkout works
legit.pl init
echo line 1 > a
echo line 1 > b
legit.pl add a b 
legit.pl commit -m "first commit"
echo line 2 >>a 
legit.pl branch
legit.pl branch b1
legit.pl branch b2
legit.pl checkout b1
echo line3 >> a 
legit.pl commit -m "second commit"
legit.pl checkout "master"
legit.pl show 1:a