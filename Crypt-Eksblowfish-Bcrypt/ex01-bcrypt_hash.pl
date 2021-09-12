#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

use Crypt::URandom qw( urandom );

use Crypt::Eksblowfish::Bcrypt qw(bcrypt_hash en_base64);

my $password = 'supercalifragilisticexpialidocious';

# Non-negative integer controlling the cost of the hash function.
# The number of operations is proportional to 2^cost.
my $cost = 5;

# Exactly sixteen octets of salt from a strong non-blocking random source
my $salt = urandom(16);

my $hash = bcrypt_hash(
    {
        key_nul => 1,
        cost    => $cost,
        salt    => $salt,
    },
    $password
);

# Encodes the octet string textually using the form of base 64
# that is conventionally used with bcrypt.
my $encoded = en_base64($hash);
say $encoded;

# Encodes the octet string as a hex string (high nybble first).
my $hex = unpack( 'H*', $hash );
say $hex;
