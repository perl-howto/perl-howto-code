#!/usr/bin/env perl
use strict;
use warnings;

use Net::Subnet;

my $is_in_my_network = subnet_matcher qw' 192.168.178.0/24 ';

my @ips = qw' 192.168.1.1 172.16.32.1 192.168.178.2 8.8.8.8 ';

foreach my $ip (@ips) {
    if ( $is_in_my_network->($ip) ) {
        print "$ip ist in meinem Subnet\n";
    } else {
        print "$ip ist nicht in meinem Subnet\n";
    }
}
