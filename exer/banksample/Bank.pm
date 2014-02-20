#!/usr/bin/perl

use warnings;
require BankAccount;
require Exporter;
our @ISA = qw/Exporter/;
our @Exporter = qw/BankAccount/;

package Bank;

#constructor takes two arguments, bank name and nextAccountNo.
sub new {
        my $class = shift;
        my $self = {
                name => shift,
                accountBase => {}, #hash reference
                nextAccountNumber => shift,
        };
        bless $self, $class;
        return $self;
}

#Need consumer name as argument for creating a new account.
sub newAccount {
	my ($self, $consumer) = @_;
	my $accountnum = $self->{nextAccountNumber};
	#create bankaccount object.
	my $newc = BankAccount->new($consumer,$acountnum);
	$self->{accountBase}{$accountnum} = $newc;
	$self->{nextAccountNumber}=$self->{nextAccountNumber}+1;
	return $accountnum;
}

#need account number as key to get this user's balance.
sub getBalance {
	my ($self,$accnum) = @_;
	my $getacc = $self->{accountBase}{$accnum};
	return $getacc->getBalance();
}	

#go into bankaccount object and change the balance
sub deposit {
	my ($self,$accnum,$amount) = @_;
        my $getacc = $self->{accountBase}{$accnum};	
	$getacc->deposit($amount);
}	

sub withdraw {
	my ($self,$accnum,$amount) = @_;
        my $getacc = $self->{accountBase}{$accnum};
        $getacc->withdraw($amount);
}

sub applyInterests {
	my ($self) = @_;
	$hash1 = $self->{accountBase};
	#go through all keys in accountBase for the purpose of all users updating.
	while( my ($k, $v) = each %$hash1 ) {
		my $acc = $self->{accountBase}{$k};	
		my $inc = 0.01*$acc->getBalance();
		$acc->deposit($inc);
    }
}

sub listAccounts {
	my ($self) = @_;
	my @array1 = ();
        $hash1 = $self->{accountBase};
        while( my ($k, $v) = each %$hash1 ) {
    		push @array1, $k;
	}
	#use selection sort to get a sorted account number array
	foreach my $i (0 .. $#array1- 1)
        {my $min = $i + 1;
        $array1[$_] < $array1[$min] and $min = $_ foreach $min .. $#array1;
        $array1[$i] > $array1[$min] and @array1[$i, $min] = @array1[$min, $i];}
	my @array2 = reverse(@array1);
	#print every details of each account
	foreach (@array2){
		my $acc = $self->{accountBase}{$_};
		$acc->{accountNo} = $_;
		$acc->printAccountDetails();
	}
}

