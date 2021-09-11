#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Finance::TA;

use Data::Dumper;

# Style 2 (the default) outputs a very readable form which lines up the hash keys.
# Style 3 is like style 2, but also annotates the elements of arrays with their index
# (but the comment is on its own line, so array output consumes twice the number of lines)
$Data::Dumper::Indent = 3;

# Data straight from https://metacpan.org/dist/Finance-TA/view/TA.pod
my @series = (
    '91.500000', '94.815000', '94.375000', '95.095000', '93.780000', '94.625000',
    '92.530000', '92.750000', '90.315000', '92.470000'
);

# https://metacpan.org/dist/Finance-TA/view/TA.pod#TA_SMA-(Simple-Moving-Average)
# TA_SMA (Simple Moving Average)
# ($retCode, $begIdx, $outReal) = TA_SMA($startIdx, $endIdx, \@inReal, $optInTimePeriod);
#
my $startIdx        = 0;
my $endIdx          = $#series;
my $optInTimePeriod = 3;
my ( $retCode, $begIdx, $result ) = TA_SMA( $startIdx, $endIdx, \@series, $optInTimePeriod );

# Die on TA errors
die "Error TA_SMA $retCode" unless $retCode == $TA_SUCCESS;

# Debug
say 'Length @series:  ', scalar @series;
say 'Length @$result: ', scalar @$result;
say "begIdx: $begIdx";

# Dump both arrays
say '--- series ---';
say Dumper( \@series );
say '--- result ---';
say Dumper($result);

# Loop over @series and @$results
for ( my $i = 0 ; $i < $begIdx ; $i++ ) {
    say "$i: $series[$i] --> N/A";
}

for ( my $i = $begIdx ; $i <= $#series ; $i++ ) {
    say "$i: $series[$i] --> $result->[$i - $begIdx] ";
}
