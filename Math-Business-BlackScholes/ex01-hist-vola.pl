#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Finance::QuoteHist;
use Math::Business::BlackScholes qw/historical_volatility/;

my @symbols       = qw/^DJI ^GDAXI/; # Dow Jones and DAX indices
my $days_per_year = 252; # Trading days per year

# Defaults to Finance::QuoteHist::Yahoo
my $q = Finance::QuoteHist->new(
    symbols    => [@symbols],
    start_date => '30 business days ago',
    end_date   => 'today',
);

foreach my $symbol (@symbols) {
    my @closing_prices;
    # Iterate over quotes and collect closing prices
    foreach my $quote ( $q->quotes() ) {
        my ( $sym, $date, $open, $high, $low, $close, $volume ) = @$quote;
        next unless $sym eq $symbol;
        push @closing_prices, $close;
    }
    my $days_in_scope         = scalar @closing_prices;
    my $historical_volatility = historical_volatility( \@closing_prices, $days_per_year );
    say "Centered historical volatility ($days_in_scope days) for $symbol: $historical_volatility";
}
