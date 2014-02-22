#!/usr/bin/perl
use strict;
use warnings;

my $file1 = @ARGV;
open (MYFILE , $ARGV[0]);
while (<MYFILE>)
{
my @matches = $_ =~ /\b[B|X|M|Q|S][x|M]?M?\d*[A|a|b]?\b/g;
foreach (@matches)
{print $_, "\n";}
}
close (MYFILE);
