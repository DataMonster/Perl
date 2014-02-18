#!/usr/bin/perl -w
#use strict;
use warnings;
use Net::Twitter;
use Text::Trim qw(trim);
use Scalar::Util 'blessed';
use Lingua::EN::FindNumber;
use Lingua::EN::NameCase 'NameCase';
use Lingua::Stem qw/stem/; 
  
# Application Oauth:
our $consumer_key  ='4SF5q51bnBNxJl2pBx2LQ';
our $consumer_secret = 'Zg8xRYerijqmUDuQn7EIUM8sl2Ddq9qleX4WdvJ3A';
our $token = '1010339173-h0A3mdUV4woMGG4SFHDLBRE9b0I4m60jfLYpCtE';
our $token_secret = 'vamqePI2RMM1sRsn00a2TS9oWVLOd9tQi41beiUJYvpNZ';

$| = 1;
# As of 13-Aug-2010, Twitter requires OAuth for authenticated requests
#target : id, following, followed_by, screen_name,
#source : id, notifications_enable, can_dm, following, want_retweets, screen_name, all_relies, blocking. followed_by#
my $nt = Net::Twitter->new(
    traits   => [qw/API::RESTv1_1/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $token,
    access_token_secret => $token_secret,
);

my @idList = (); 
open(MYFILE, "data.txt");
    while(<MYFILE>)
    {
        chomp($_);
        my @onedata = split(/\s/,$_);
        push @idList, $onedata[0];
        #print "$onedata[0]\n";
        #$notes{$note[0]} = $note[1];
    }
    
print @idList,"\n";
foreach(@idList) {
my $r = $nt->followers_list({user_id => $_ }); #screenname search or id search, if no arrgument, then it is self.
my @friends = @{$r->{users}};

open (MYFILE1, '>>follower.txt');
print MYFILE1 $_, " ";
#foreach (@friends){
#    print MYFILE1 $_, " "; 
#}

for ($i=0;$i<scalar @friends; $i++){
    print MYFILE1 $friends[$i]{id}," ";
}

print MYFILE1 "\n";
close (MYFILE1);
close (MYFILE);
sleep(2);
print $_,"\n";
}
