#!/usr/bin/env perl
use strict;
use warnings;

use Net::Subnet;

my $rfc1918_classifier = subnet_classifier qw' 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 ';

my @ips = qw/ 192.168.1.1 172.16.32.1 192.168.178.2 8.8.8.8 /;

foreach my $ip (@ips) {
    my $subnet =  $rfc1918_classifier->($ip);
    if ( $subnet ) {
        print "$ip befindet sich im Subnetz '$subnet'\n";
    } else {
        print "$ip befindet sich in keinem Subnetz der Liste\n";
    }
}
