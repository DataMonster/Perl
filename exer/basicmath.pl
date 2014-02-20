#!/usr/bin/perl

use warnings;
require Exporter;
@ISA = qw/Exporter/;
@EXPORT = qw/BasicMath/;

package BasicMath;
sub max {
	my @array1 = @_;
	#use selection sort to get sorted array.
        foreach my $i (0 .. $#array1- 1)
        {my $min = $i + 1;
        $array1[$_] < $array1[$min] and $min = $_ foreach $min .. $#array1;
        $array1[$i] > $array1[$min] and @array1[$i, $min] = @array1[$min, $i];}
	$array1[-1];#the last item is the largest.
}

sub min {
	my @array1 = @_;
        foreach my $i (0 .. $#array1- 1)
        {my $min = $i + 1;
        $array1[$_] < $array1[$min] and $min = $_ foreach $min .. $#array1;
        $array1[$i] > $array1[$min] and @array1[$i, $min] = @array1[$min, $i];}
        $array1[0];
	# the first item is the smallest.
}


sub med {
	my @array1 = @_;
        foreach my $i (0 .. $#array1- 1)
        {my $min = $i + 1;
        $array1[$_] < $array1[$min] and $min = $_ foreach $min .. $#array1;
        $array1[$i] > $array1[$min] and @array1[$i, $min] = @array1[$min, $i];}
   	my $length = scalar(@array1);
	$array1[$length/2-1];
}

