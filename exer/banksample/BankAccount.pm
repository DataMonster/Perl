#!/usr/bin/perl

use warnings;
require Exporter;
our @ISA = qw/Exporter/;
our @Exporter = qw/BankAccount/;
package BankAccount;

#Create object with 2 or 3 arrguments, name and accountNo are necessary, but balance can be default to 0;
sub new
{
	my $class = shift;
	my $self = {
		name => shift,
		accountNo => shift,
		balance => shift,
	};
    	#my $self = {};
	bless $self, $class;
	return $self;
}

sub getName {
	my( $self ) = @_;
	return $self -> {name};
}

sub getAccountNo {
	my( $self ) = @_;
	return $self -> {accountNo};
}

#if balance is not defined, use this sub will set balance to 0;
sub getBalance {
	my( $self ) = @_;
	if ($self->{balance}){
		return $self -> {balance};
	}
	else {
		$self->{balance} = 0;	
		return $self -> {balance};
	}
}

sub deposit {
	my( $self, $amount ) = @_;
	$self->{balance} = $self->{balance} + $amount;
	return $self->{balance};
}

sub withdraw {
	my( $self, $amount ) = @_;
        $self->{balance} = $self->{balance} - $amount;
        return $self->{balance};
}

sub printAccountDetails {
	my( $self ) = @_;
	print "Name: ",$self-> getName()," ", "AccountNo: ",$self->getAccountNo()," ", "Balance: ", $self->getBalance(),"\n";
}

