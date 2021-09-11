#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

use Text::CSV::Slurp;
use Finance::TA;

use Data::Dumper;
$Data::Dumper::Indent = 3;

# CSV Input
my $filename = './spy_d.csv';
# CSV Output
my $csv_encoding = 'utf-8';
my $out_filename = './spy_d_indicators.csv';

# CSV Options - see Text::CSV
my %csv_options = (
    sep_char => ',',
    binary   => '1',
);

my $slurp = Text::CSV::Slurp->new();

# Reference to an array of hashes
my $data = $slurp->load( file => $filename, %csv_options );
# Reference to an array
my $highs = [ map { $_->{High} } @$data ];
# Reference to an array
my $lows = [ map { $_->{Low} } @$data ];
# Reference to an array
my $closes = [ map { $_->{Close} } @$data ];

my $startIdx = 0;        # First element of @$data
my $endIdx   = $#$data;  # Last element of @$data

my $retCode;
my $begIdx;

# TA_ADX (Average Directional Movement Index)
# ($retCode, $begIdx, $outReal) = TA_ADX($startIdx, $endIdx, \@high, \@low, \@close, $optInTimePeriod);
my $optInTimePeriod_adx = 9;    # Defaults to 14
my $adx;
( $retCode, $begIdx, $adx ) = TA_ADX( $startIdx, $endIdx, $highs, $lows, $closes, $optInTimePeriod_adx );
die "Error TA_ADX:  $retCode" unless $retCode == $TA_SUCCESS;
fill_datastructure( data => $data, results => $adx, begIdx => $begIdx, key => 'ADX' );

# TA_SAR (Parabolic SAR)
# ($retCode, $begIdx, $outReal) = TA_SAR($startIdx, $endIdx, \@high, \@low, $optInAcceleration, $optInMaximum);
my $optInAcceleration = 0.02;
my $optInMaximum      = 0.2;
my $psar;
( $retCode, $begIdx, $psar ) = TA_SAR( $startIdx, $endIdx, $highs, $lows, $optInAcceleration, $optInMaximum );
die "Error TA_SAR:  $retCode" unless $retCode == $TA_SUCCESS;
fill_datastructure( data => $data, results => $psar, begIdx => $begIdx, key => 'PSAR' );

# TA_SMA (Simple Moving Average)
# ($retCode, $begIdx, $outReal) = TA_SMA($startIdx, $endIdx, \@inReal, $optInTimePeriod);
## Fast SMA
my $optInTimePeriod_fast_sma = 9;
my $fast_sma;
( $retCode, $begIdx, $fast_sma ) = TA_SMA( $startIdx, $endIdx, $closes, $optInTimePeriod_fast_sma );
die "Error fast TA_SMA $retCode" unless $retCode == $TA_SUCCESS;
fill_datastructure( data => $data, results => $fast_sma, begIdx => $begIdx, key => 'Fast SMA' );
## Slow SMA
my $optInTimePeriod_slow_sma = 18;
my $slow_sma;
( $retCode, $begIdx, $slow_sma ) = TA_SMA( $startIdx, $endIdx, $closes, $optInTimePeriod_slow_sma );
die "Error slow TA_SMA $retCode" unless $retCode == $TA_SUCCESS;
fill_datastructure( data => $data, results => $slow_sma, begIdx => $begIdx, key => 'Slow SMA' );

# Debug
#say Dumper( \$data );

# Create Output CSV
my $field_order = [ 'Date', 'Open', 'Low', 'High', 'Close', 'ADX', 'PSAR', 'Fast SMA', 'Slow SMA' ];

my $csv = $slurp->create( input => $data, field_order => $field_order, %csv_options );

open my $fh, ">:encoding($csv_encoding)", "$out_filename" or die "$!";
print $fh $csv;
close($fh) or die $!;

exit();

=head1 SUBROUTINES/METHODS

=cut

=head2 fill_datastructure

 fill_datastructure(data => $data, results => $results, begIdx => $begIdx, key => 'string');

Fills datastructure C<@$data> with values from Finance:TA C<$results> using C<key> as hash key.

Slots below C<$begIdx> will be filled with C<undef> values.

Will warn on overwriting existing hash keys.

=cut

sub fill_datastructure {
    my %args     = @_;
    my $data_ref = $args{data};
    my $results  = $args{results};
    my $begIdx   = $args{begIdx};
    my $key      = $args{key};

    # Check params
    die("Missing arg 'data'.")    unless $data_ref;
    die("Missing arg 'results'.") unless $results;
    die("Missing arg 'begIdx'.")  unless defined $begIdx;
    die("Missing arg 'key'.")     unless $key;
    # Minimal params validation
    unless ( ref($data_ref) eq 'ARRAY' ) { die('No ARRAY reference found for $data.'); }
    unless ( ref($results) eq 'ARRAY' )  { die('No ARRAY reference found for $results.'); }

    # Fill datastructure
    for ( my $i = 0 ; $i <= $#$data_ref ; $i++ ) {
        # Emitt warning on overwriting data
        if ( exists $data_ref->[$i]->{$key} ) {
            warn("Overwriting data key '$key' at '$i'");
        }
        my $value = undef;
        if ( $i >= $begIdx ) {
            $value = $results->[ $i - $begIdx ];
        }
        $data_ref->[$i]->{$key} = $value;
    }
}
__END__

