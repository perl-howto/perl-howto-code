#!/usr/bin/env perl 
use strict;
use warnings;

use feature 'say';

use AWS::Networks;
use Net::CIDR::Set;

my $region_set  = cidr_set_for_region('eu-west-1');
my $service_set = cidr_set_for_service('EC2');

my $overlap = $region_set->intersection($service_set);

my $iter = $overlap->iterate_cidr;
while ( my $cidr = $iter->() ) {
    say $cidr;
}
exit();

# Returns a Net::CIDR::Set object filled with AWS CIDRs for $service
sub cidr_set_for_service {
    my $service  = shift;
    my $nets     = AWS::Networks->new();
    my $s        = $nets->by_service($service);
    my $cidrs    = $s->cidrs;
    my $cidr_set = Net::CIDR::Set->new(@$cidrs);
    return $cidr_set;
}
# Returns a Net::CIDR::Set object filled with AWS CIDRs for $region
sub cidr_set_for_region {
    my $region   = shift;
    my $nets     = AWS::Networks->new();
    my $r        = $nets->by_region($region);
    my $cidrs    = $r->cidrs;
    my $cidr_set = Net::CIDR::Set->new(@$cidrs);
    return $cidr_set;
}
