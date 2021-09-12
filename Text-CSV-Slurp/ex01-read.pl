#!/usr/bin/env perl
use strict;
use warnings;

use Text::CSV::Slurp;

my $slurp = Text::CSV::Slurp->new();

my $filename = './1.csv';

# CSV Options - see Text::CSV
my %csv_options = (
    sep_char => ';',
    binary   => '1',
);

# Reference to an array of hashes
my $data = $slurp->load( file => $filename, %csv_options );

foreach my $row (@$data) {
    # $row holds a reference to a hash
    print "$row->{givenname} $row->{surname} $row->{phone}\n";
}
