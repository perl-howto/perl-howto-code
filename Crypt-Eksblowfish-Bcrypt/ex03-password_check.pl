#!/usr/bin/env perl

use strict;
use warnings;
use feature "say";

use Crypt::Eksblowfish::Bcrypt "en_base64", "de_base64", "bcrypt_hash";

# Cleartext password from user input
my $pass_input = "12345678";

# bcrypt hash string from password storage or other application
# e.g.  my $bcrypt_hash_string = qx{php -r 'echo password_hash($pass_input, PASSWORD_BCRYPT);'};
my $bcrypt_hash_string = '$2y$10$GI7ziJuT2wADu1BQMhnDKOJL5dYnpJj2zoGWwS2MrKgdgmGYHHzrq';

my ( $unused, $algorithm, $cost, $salt_and_pass ) = split /\$/, $bcrypt_hash_string;

# 22 character salt (base64 encoded)
my $salt = substr $salt_and_pass, 0, 22;
# 31 character bcrypt hash (base64 encoded)
my $encoded_pass_hash = substr $salt_and_pass, 22, 31;

# Debug
say "$algorithm, $cost, $salt_and_pass, $salt, $encoded_pass_hash";

# Comput bcrypt hash using identified cost and salt
my $perl_bcrypt_hash = en_base64(
    bcrypt_hash(
        {
            cost    => $cost,
            key_nul => 1,
            salt    => de_base64($salt)
        },
        $pass_input
    )
);

# Method 1
# compare supplied bcrypt hash string from password storage
# with computed (Perl) bcrypt hash string
# Assemble (Perl) bcrypt hash string
my $perl_bcrypt_hash_string = sprintf '$%s$%d$%s%s', $algorithm, $cost, $salt, $perl_bcrypt_hash;

# Debug
say "";
say "Other $bcrypt_hash_string";
say "Perl  $perl_bcrypt_hash_string";

if ( $bcrypt_hash_string eq $perl_bcrypt_hash_string ) {
    say "Okay. Password hash strings match.";
} else {
    say "Sorry. Password hash strings do not match";
}

# Method 2
# or compare encoded hashes
# Debug
say "";
say "Other $encoded_pass_hash";
say "Perl  $perl_bcrypt_hash";
if ( $encoded_pass_hash eq $perl_bcrypt_hash ) {
    say "Okay. Password hashes match.";
} else {
    say "Sorry. Password hashes do not match";
}
