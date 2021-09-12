#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

use Crypt::URandom qw( urandom );

use Crypt::Eksblowfish::Bcrypt qw(bcrypt en_base64);

my $password = 'supercalifragilisticexpialidocious';

# Non-negative integer controlling the cost of the hash function.
# The number of operations is proportional to 2^cost.
my $cost = 5;

# Exactly sixteen octets of salt from a strong non-blocking random source
my $salt         = urandom(16);
my $salt_encoded = en_base64($salt);

# Assemble settings string
my $settings;
# "$2", optional "a", $
# only a is supported - b or y will yield an error
$settings .= '$2a$';
# cost as two digits (leading zero)
$cost = sprintf( "%02d", $cost );
$settings .= $cost;
# $
$settings .= '$';
# 22 base 64 digits (salt)
$settings .= $salt_encoded;

my $bycrypt_storage_string = bcrypt( $password, $settings );

# Debug
say "Settings:      $settings";
say "Bcrypt string: $bycrypt_storage_string";
