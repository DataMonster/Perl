#!/usr/bin/perl -w
#use strict;
use warnings;
use Net::Twitter;
use Text::Trim qw(trim);
use Scalar::Util 'blessed';
use Lingua::EN::FindNumber;
use Lingua::EN::NameCase 'NameCase';
use Lingua::Stem qw/stem/; 
  

my @idList = ();
my @totalFollower = ();
my ($i,$j,$k);
open(MYFILE, "follower.txt");
    while(<MYFILE>)
    {
        my @followers = ();
        chomp($_);
        my @onedata = split(/\s/,$_);
        push @idList, $onedata[0];
        for ($i=1;$i<scalar @onedata;$i++){
            push @followers, $onedata[$i];
        }
        push @totalFollower, [@followers];
    }
    close (MYFILE);

open (MYFILE1, '>>relation.txt');

for ($i=0;$i<scalar @idList; $i++){
    for ($j=0;$j<scalar @idList; $j++){
       for($k=0;$k<scalar @{$totalFollower[$j]};$k++){
           # print $idList[$i], $totalFollower[$j][$k],"\n";
           if ($idList[$i] eq $totalFollower[$j][$k]){
                print $idList[$i]," follows ", $idList[$j],"\n";
                print MYFILE1 $idList[$i]," ", $idList[$j],"\n";
             }
        }
    }
}

close (MYFILE1);

