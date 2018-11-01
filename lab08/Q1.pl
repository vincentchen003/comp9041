#!/usr/bin/perl -w
my @array = ( 'a', 'b', 'c', 'a', 'd', 1, 2, 5, 1, 5 );
my %count;
my @uniq_times = grep { ++$count{ $_ } < 2; } @array;
print "@uniq_times\n"