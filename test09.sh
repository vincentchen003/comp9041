#!/bin/sh
#check the combination of branch and checkout works
legit.pl init
seq 1 10 > a
legit.pl add a
legit.pl commit -m "first commit"
legit.pl branch b1
legit.pl checkout branch b1
perl -pi -e 's/2/12/' a
legit.pl commit -m "second commit"
legit.pl checkout master
legit.pl merge b1 -m merge-message
cat a