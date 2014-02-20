#!/usr/bin/perl

use warnings;
use strict;
use BasicMath;

print "\n";
print "Test 1 : sub max (\@input) : \n max (23, 35, 2, 19 , 8, 122) is ";
print BasicMath::max(23, 35, 2, 19 , 8, 122),"\n";
print "Test 3 : sub min (\@input) : \n min (23, 35, 2, 19 , 8, 122) is ";
print BasicMath::min(23, 35, 2, 19 , 8, 122),"\n";
print "Test 3 : sub med (\@input) : \n med (23, 35, 2, 19 , 8, 122) is ";
print BasicMath::med(23, 35, 2, 19 , 8, 122),"\n";
print "\n";
