#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Finance::TA;

# Data straight from https://metacpan.org/dist/Finance-TA/view/TA.pod
my @series = (
    '91.500000', '94.815000', '94.375000', '95.095000', '93.780000', '94.625000',
    '92.530000', '92.750000', '90.315000', '92.470000'
);

# https://metacpan.org/dist/Finance-TA/view/TA.pod#TA_SMA-(Simple-Moving-Average)
# TA_SMA (Simple Moving Average)
# ($retCode, $begIdx, $outReal) = TA_SMA($startIdx, $endIdx, \@inReal, $optInTimePeriod);
#
my $startIdx = 0;
my $endIdx   = $#series;

# Fast SMA
my $optInTimePeriod_fast_sma = 3;
my ( $retCode_fast_sma, $begIdx_fast_sma, $result_fast_sma ) =
  TA_SMA( $startIdx, $endIdx, \@series, $optInTimePeriod_fast_sma );
# Die on TA errors
die "Error fast TA_SMA $retCode_fast_sma" unless $retCode_fast_sma == $TA_SUCCESS;

# Slow SMA
my $optInTimePeriod_slow_sma = 4;
my ( $retCode_slow_sma, $begIdx_slow_sma, $result_slow_sma ) =
  TA_SMA( $startIdx, $endIdx, \@series, $optInTimePeriod_slow_sma );
# Die on TA errors
die "Error slow TA_SMA $retCode_slow_sma" unless $retCode_slow_sma == $TA_SUCCESS;

my $format = "%s | %10s | %10s | %20s |\n";
printf( $format, 'i', 'value', 'slow_sma', 'fast_sma' );
for ( my $i = 0 ; $i <= $#series ; $i++ ) {
    my $value    = $series[$i];
    my $fast_sma = 'N/A';
    my $slow_sma = 'N/A';
    if ( $i >= $begIdx_fast_sma ) {
        $fast_sma = $result_fast_sma->[ $i - $begIdx_fast_sma ];
    }
    if ( $i >= $begIdx_slow_sma ) {
        $slow_sma = $result_slow_sma->[ $i - $begIdx_slow_sma ];
    }
    printf( $format, $i, $value, $slow_sma, $fast_sma );
}
