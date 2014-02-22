#!/usr/bin/perl
use List::Util qw(first);
#use strict;
use warnings;

my $file1 = @ARGV;
my @square=();
my @count=();
my $totalnum =0;
my $num =0;
open(MYFILE, $ARGV[0]);
while(<MYFILE>)
{
my @matches = $_ =~ /[0-9]*[\.]*[BKNQR]?[a-h]?[0-9]?[x|=]?[a-h][1-8][+|#]?\!*[\?]*!?/g;
foreach (@matches){	
	($n, $p, $f, $r, $a, $d, $c, $an) = $_ =~ /(\d?+\.?+)([BKNQR]?)([a-h]?)([0-9]?)([x=]?)([a-h][1-8])([+|#]?)(!*[\?]*!?)/;
	if($d)
	{
		if(@square){	
		my $index = first{$square[$_] eq $d}0..$#square;
		if(defined $index){
			$count[$index]++;		
		}
		else{
		push @square, $d;
		push @count,1;
		}
		}
		else{push @square,$d;
		push @count, 1;	}
	}
	if($an){
	$num++;}
	$totalnum++;
}
}
close (MYFILE);
print "Percent of moves followed by symbols:", $num/$totalnum*100, "%\n";
print "Unique squares:\n";
for ($i=0;$i<scalar @count;$i++){
print $square[$i], "  ", $count[$i],"\n";
}
