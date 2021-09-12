#!/usr/bin/env perl
use strict;
use warnings;

use Net::Subnet;

my @subnets = qw~ 172.16.0.0/12  172.16.0.0/16 172.16.0.0/22
  172.16.31.0/24 172.16.31.0/22 ~;

# Smaller networks will show up first
my @sorted_subnets = sort_subnets(@subnets);

foreach my $subnet (@sorted_subnets) {
    print $subnet, "\n";
}
