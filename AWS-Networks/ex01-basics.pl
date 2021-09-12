#!/usr/bin/env perl 
use strict;
use warnings;

use AWS::Networks;

my $nets = AWS::Networks->new();

print $nets->sync_token->iso8601, "\n";

foreach my $cidr ( @{ $nets->cidrs } ) {
    print "$cidr\n";
}
