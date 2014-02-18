#!/usr/bin/perl -w
#use strict;
use open ':std', ':encoding(UTF-8)';
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

# As of 13-Aug-2010, Twitter requires OAuth for authenticated requests
my $nt = Net::Twitter->new(
    traits   => [qw/API::RESTv1_1/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $token,
    access_token_secret => $token_secret,
);

sub getT {
my $nt = $_[0];
my $countt = 1;
my @followingList = ();
my @followerList = ();
my @tweets = ();
my $id = $_[1];#'RealPaulWalker';
my $topic = $_[2];#'Paul Walker';
my $score = 0;

#get user tweets
my $onetweet = '';
eval {
    my $statuses = $nt->user_timeline({ id => $id , count => 200 });
    for my $status ( @$statuses ) {
        $onetweet = $status->{text};
        push @tweets, $onetweet;
        #print "$status->{created_at} <$status->{user}{screen_name}> $status->{text}\n";
    }
};
if ( my $err = $@ ) {
    
    #print "!!!!\n";
    die $@ unless blessed $err && $err->isa('Net::Twitter::Error');
 
    warn "HTTP Response Code:1 ", $err->code, "\n",
         "HTTP Message......:2 ", $err->message, "\n",
         "Twitter error.....:3 ", $err->error, "\n";
    return $score;
}

#read note for dictionary
if (!@tweets) {
    return $score;
}

open (MYFILE1, ">>contents/$id.txt");
    foreach (@tweets){ print MYFILE1 $_, "\n";}
#close (MYFILE1);
    
@outtweets = ();
foreach (@tweets){
    my %notes = ();
    my $outtweet = '';
    my $outtweet1 = '';
    my $text = $_;
    $text = numify($text);
    open(MYFILE, "notes.txt");
    while(<MYFILE>)
    {
        chomp($_);
        my @note = split(/\s=\s/,$_);
        $notes{$note[0]} = $note[1];
    }

#namcase
$text  = NameCase( $text ) ;
my @tweetWords = split / /, $text;
my $pos = 0;
foreach (@tweetWords){
    my $tweetWord = $_;
    foreach (keys %notes) {
        if ($tweetWord eq $_) {
            $tweetWords[$pos] = $notes{$_};
        }
    }
    $pos ++;
}

#stem
my $tweetStems = stem(@tweetWords);
my @tweetResult = @$tweetStems;

for (my $i =0 ; $i < (scalar @tweetResult); $i++){
    
    $outtweet1 = trim($tweetResult[$i]);
    #print $outtweet,"\n";
    $outtweet = $outtweet." ".$outtweet1;
}
$outtweet = trim($outtweet);
push @outtweets, $outtweet; 
}

open (MYFILE2, ">>modi_contents/$id.txt");
foreach (@outtweets){
    print MYFILE2 $_, "\n";}

#topic adjust:
#topic can be: example 'New York', 'new york', 'New york', 'NewYork', 'Newyork', 'newyork'.
#to get a better result, use 'new york', 'newyork' to search
#devide each topic in to words array, so we have, 2 patterns
#dict->NameCase->stem->combine with space/combine without space
#set these two into an topic array, then use it to score the tweets.
$topic = NameCase(trim($topic));
#dict, namecase
my @topicWords = split / /, $topic;
my $pos2 = 0;
foreach (@topicWords){
    $topicWord = $_;
    foreach (keys %notes) {
        if ($topicWord eq $_) {
            $topicWords[$pos2] = $notes{$_};
        }
    }
    $pos2 ++;
}

#stem
my $outtopic = '';
my $outtopic2 = '';
my $topicStems = stem(@topicWords);
my @topicResult = @$topicStems;

for ($i =0 ; $i < (scalar @topicResult); $i++){
    $outtopic = trim($outtopic);
    $outtopic2 = trim($outtopic2);
    $outtopic = $outtopic." ".$topicResult[$i];
    $outtopic2 = $outtopic2.$topicResult[$i];
}

#print $outtopic2,"\n";

#pattern matching for regEx of topic in all tweets
#use score as result for this users about a topic.

foreach(@outtweets){
    if ($_ =~ m/$outtopic/ || $_ =~ m/$outtopic2/) {
        $score ++ ;
    }
}
close (MYFILE1);
close (MYFILE2);
return $score;
}
#print scalar @followingList, " ", scalar @followerList, "\n";

#print getT($nt,'42712551','Paul Walker');
#42712000,42714090;42715300;42718190
#$ARGV[2]='Paul Walker';
for (my $index=0; $index<=$ARGV[1]; $index++)
{my $startId = $ARGV[0]+170*$index;
my $endId = $ARGV[0]+170*($index+1);

my %resultSet = ();
my $scoreGet = 0;
#print 2,"\n";
$| = 1;
for (my $i=$startId;$i<$endId;$i++){
    $scoreGet = getT($nt,$i,'Paul Walker');
    if ($scoreGet > 0){
        $resultSet{$i}=$scoreGet;
    }
    sleep(1);
    #not too fast, avoid the TWITTER.COM warning.
    print $i,".";
    #print $i," ",$scoreGet,"\n";
}
print "\nGet results: \n";
print "$_\n" for keys %resultSet;
open (MYFILE, '>>data.txt');

foreach (keys %resultSet){
    print MYFILE $_, " ", $resultSet{$_}, "\n";
}

close (MYFILE);
sleep(900);
#sleep 900 seconds, which is 15 minutes, because TWITTER.COM only allow about 170 queries per 15 minutes.
}
