#!/usr/bin/env perl
use strict;
use warnings;

use Net::Subnet;

my $is_rfc1918 = subnet_matcher qw' 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 ';

my @ips = qw/ 192.168.1.1 172.16.32.1 192.168.178.2 8.8.8.8 /;

foreach my $ip (@ips) {
    if ( $is_rfc1918->($ip) ) {
        print "$ip ist eine private IP-Adresse\n";
    } else {
        print "$ip ist keine private IP-Adresse\n";
    }
}
