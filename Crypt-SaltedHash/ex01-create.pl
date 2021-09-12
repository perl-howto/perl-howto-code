#!/usr/bin/env perl
use strict;
use warnings;

use Crypt::SaltedHash;

my $csh = Crypt::SaltedHash->new( algorithm => 'SHA-1' );

my $cleartext = 'secret';

$csh->add( $cleartext );

my $salted = $csh->generate;

print "Salted: $salted\n";
