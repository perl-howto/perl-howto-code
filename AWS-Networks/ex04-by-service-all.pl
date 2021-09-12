#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

use AWS::Networks;

my $nets = AWS::Networks->new();

foreach my $service ( @{ $nets->services } ) {
    say "$service";
}
