#!/usr/bin/env perl
use strict;
use warnings;

use Session::Token;

my $generator = Session::Token->new;

my $token = $generator->get;
print "Token: $token\n";

# Again
$token = $generator->get;
print "Token: $token\n";

