#!/bin/sh
#check the log function works
legit.pl init
echo line 1 > a
legit.pl add a
legit.pl commit -m "first commit"
touch b
legit.pl commit -m "second commit"
legit.pl log

