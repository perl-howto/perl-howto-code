#!/usr/bin/env perl
use strict;
use warnings;

use Session::Token;

my $token = Session::Token->new( length => 8, 
   alphabet => 'ABCDEFGHIJKLMNOPQRSTUVW1234567890!"Â§$%&/()=?' )->get;

print "Token: $token\n";
