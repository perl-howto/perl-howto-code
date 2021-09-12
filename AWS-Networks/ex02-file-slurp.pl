#!/usr/bin/env perl 
use strict;
use warnings;

use File::Slurp;
use JSON;
use AWS::Networks;

# https://ip-ranges.amazonaws.com/ip-ranges.json
my $ip_ranges_json_file = 'ip-ranges.json';

my $json = read_file($ip_ranges_json_file);
my $nets = AWS::Networks->new( netinfo => decode_json($json) );

print $nets->sync_token->iso8601, "\n";

foreach my $cidr ( @{ $nets->cidrs } ) {
    print "$cidr\n";
}
