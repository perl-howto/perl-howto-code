#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

use AWS::Networks;

my $nets = AWS::Networks->new();

foreach my $region ( @{ $nets->regions } ) {
    say "$region";
    my $aws_networks_object = $nets->by_region($region);
    foreach my $cidr ( @{ $aws_networks_object->cidrs } ) {
        say "\t$cidr";
    }
}
