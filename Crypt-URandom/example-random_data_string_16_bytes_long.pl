#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Crypt::URandom qw( urandom );

my $random_data_string_16_bytes_long  = urandom(16);

say $random_data_string_16_bytes_long;
