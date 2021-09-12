#!/usr/bin/env perl
use strict;
use warnings;

use Statistics::LineFit;

# Datensatz Lebensalter und Gewicht siehe
# https://de.wikibooks.org/wiki/GNU_R:_Anwendungsbeispiele#Beispiel_5

# Lebensalter in Tagen - X-Achse
my @xValues = ( 1, 3, 6, 11, 12, 15, 19, 23, 28, 33, 35, 39, 47, 60, 66, 73 );

# Gewicht in Gramm - Y-Achse
my @yValues = (
    3180, 2960, 3220, 3270, 3350, 3410, 3700, 3830,
    4090, 4310, 4360, 4520, 4650, 5310, 5490, 5540
);

my $lineFit = Statistics::LineFit->new();

$lineFit->setData( \@xValues, \@yValues ) or die "Invalid data";

$lineFit->regress() or die "Regression failed";

my ( $intercept, $slope ) = $lineFit->coefficients();

print "f(x) = $slope * x + $intercept\n";
print "\n";

my @predictedYs = $lineFit->predictedYs();
my @residuals   = $lineFit->residuals();

for ( my $i = 0 ; $i <= $#xValues ; $i++ ) {
    printf "X: %2s Y: %4s Y pred: %-16s Residual: %s\n", $xValues[$i],
      $yValues[$i],
      $predictedYs[$i], $residuals[$i];
}
