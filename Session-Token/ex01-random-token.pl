#!/usr/bin/env perl
use strict;
use warnings;

use Session::Token;

my $token = Session::Token->new->get;

print "Token: $token\n";
