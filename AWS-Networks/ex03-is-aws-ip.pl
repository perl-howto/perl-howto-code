#!/usr/bin/env perl 
use strict;
use warnings;

use feature 'say';

use AWS::Networks;
use Net::CIDR::Set;

my $ip = $ARGV[0];

unless ($ip) {
    die "Usage: $0 IPv4-address\n";
}

my $nets = AWS::Networks->new();

my $cidrs = $nets->cidrs;

my $cidr_set = Net::CIDR::Set->new(@$cidrs);

if ( $cidr_set->contains($ip) ) {
    say "Yes - $ip is a AWS IP.";
} else {
    say "No - $ip is not a AWS IP.";
}
