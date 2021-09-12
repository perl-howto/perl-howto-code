#!/usr/bin/env perl
use strict;
use warnings;

use Text::CSV::Slurp;

my $slurp = Text::CSV::Slurp->new();


# CSV Options - see Text::CSV
my %csv_options = (
    sep_char   => ';',
    binary     => 1,
    quote_char => '"',
    always_quote => 1,
);


# Reference to an array of hashes
my $input = [
   {
	'first' => 'Otto',
        'last'  => 'Maier',
   },
   {
	'first' => 'Hans',
        'last'  => 'Huber',
   },
];

my @field_order = qw/ last first /;

my $csv = $slurp->create( input => $input,field_order => \@field_order, %csv_options );


my $outfile = './test.csv';
my $csv_encoding = 'utf-8';

open my $fh, ">:encoding($csv_encoding)", "$outfile" or die "$!";
print $fh $csv;
close($fh);
