#!/usr/bin/env perl
use strict;
use warnings;

use Session::Token;

my $token = Session::Token->new(entropy => 256)->get;

print "Token: $token\n";
