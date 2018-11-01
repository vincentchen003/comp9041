#!/bin/sh
#check the statues function works
legit.pl init
echo line 1 > a
legit.pl add a
legit.pl commit -m "first commit"
echo line 2 >>a 
legit.pl commit -m "second commit"
echo hello > b
echo world > c
legit.pl commit -m "helloworld"
legit.pl status