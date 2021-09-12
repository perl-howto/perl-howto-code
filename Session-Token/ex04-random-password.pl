#!/usr/bin/env perl
use strict;
use warnings;

use Session::Token;

my $token = Session::Token->new( length => 8 )->get;

print "Token: $token\n";
