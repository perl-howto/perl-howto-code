#!/usr/bin/env perl
use strict;
use warnings;

use Crypt::SaltedHash;

my $csh = Crypt::SaltedHash->new( algorithm => 'SHA-1' );

my $cleartext = 'secret';

my $salted = '{SSHA}9GnzDgL3ChgeupyOkQtSrN/0/v8sGBf3';

my $valid = Crypt::SaltedHash->validate( $salted, $cleartext );

if ($valid) {
    print "OK\n";
} else {
    print "Not OK\n";
}
