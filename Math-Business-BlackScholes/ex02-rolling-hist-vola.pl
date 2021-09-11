#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Finance::QuoteHist;
use Math::Business::BlackScholes qw/historical_volatility/;

my @symbols       = qw/^DJI ^GDAXI/;    # Dow Jones and DAX indices
my $days_per_year = 252;                # Trading days per year
my $days_in_scope = 30;

# Defaults to Finance::QuoteHist::Yahoo
my $q = Finance::QuoteHist->new(
    symbols    => [@symbols],
    start_date => '45 business days ago',
    end_date   => 'today',
);

foreach my $symbol (@symbols) {
    # 3 parallel arrays
    my @closing_prices;
    my @dates;
    my @historical_vola;
    # Iterate over quotes and collect closing prices and dates
    foreach my $quote ( $q->quotes() ) {
        my ( $sym, $date, $open, $high, $low, $close, $volume ) = @$quote;
        next unless $sym eq $symbol;
        push @closing_prices, $close;
        push @dates,          $date;
    }
    # Loop over closing_prices,
    # slice array @closing_prices to suit historical_volatility()
    # and collect dates and hist vola
    for ( my $i = 0 ; $i <= $#closing_prices ; $i++ ) {
        $historical_vola[$i] = 'N/A';
        if ( $i >= $days_in_scope - 1 ) {
            # Array slice from current index (upper) back down to lookup period (days in scope) -1 (lower)
            my $lower                   = $i - ( $days_in_scope - 1 );
            my @closing_prices_in_scope = @closing_prices[ $lower .. $i ];
            $historical_vola[$i] = historical_volatility( \@closing_prices_in_scope, $days_per_year );
        }
    }
    # Loop over closing_prices and display index, current symbol, closing price and computed vola
    for ( my $i = 0 ; $i <= $#closing_prices ; $i++ ) {
        say "$i $symbol $dates[$i] $closing_prices[$i] $historical_vola[$i]";
    }
}
