#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

use AWS::Networks;

my $nets = AWS::Networks->new();

foreach my $service ( @{ $nets->services } ) {
    say "$service";
    my $aws_networks_object = $nets->by_service($service);
    foreach my $cidr ( @{ $aws_networks_object->cidrs } ) {
        say "\t$cidr";
    }
}
