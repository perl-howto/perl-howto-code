#!/usr/bin/env perl 
use strict;
use warnings;

use feature 'say';

use AWS::Networks;
use Net::CIDR::Set;

# http://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html

# Implementing Egress Control

# To allow an instance to access only AWS services, create a security group
# with rules that allow outbound traffic to the CIDR blocks in the AMAZON list,
# minus the CIDR blocks that are also in the EC2 list.

my $amazon_set = cidr_set_for_service('AMAZON');
my $ec2_set    = cidr_set_for_service('EC2');

my $egress_set = $amazon_set->diff($ec2_set);

my $iter = $egress_set->iterate_cidr;
while ( my $cidr = $iter->() ) {
    say $cidr;
}
exit();

# Returns a Net::CIDR::Set object filled with
# AWS CIDRs for $service
sub cidr_set_for_service {
    my $service  = shift;
    my $nets     = AWS::Networks->new();
    my $s        = $nets->by_service($service);
    my $cidrs    = $s->cidrs;
    my $cidr_set = Net::CIDR::Set->new(@$cidrs);
    return $cidr_set;
}
