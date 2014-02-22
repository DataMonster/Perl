#!/usr/bin/perl
use strict;
use warnings;

my $file1 = @ARGV;
my $count =0;
open (MYFILE , $ARGV[0]);
open (OUTFILE, '>>test2n.txt');
while (<MYFILE>)
{
my $out = "";
my $result = "";
my @matches = $_ =~ /(\b\W*\d{3}\W*\d{3}\W*\d{4}\b)/g;
$count =$count + scalar( @matches);
foreach (@matches)
{
	my @split = $_=~ /(\b\d{3}\b)/g;
	my @split2 = $_ =~ /(\b\d{4}\b)/g;
	if (@split){
	$out = "(".$split[0].") ".$split[1];
	$result = $out." ".$split2[0];
	}
	else{
	$result = "(".substr($_,0,3).") ".substr($_,3,3)." ".substr($_,6,4); 
	}
	print OUTFILE "$result\n";
}
}
print "The passage contains $count phone number mentions \n";
print "# output file with normalized numbers ‘test2n.txt’ created 
";
close (MYFILE);
close (OUTFILE);
