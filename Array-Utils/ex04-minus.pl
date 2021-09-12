#!/usr/bin/env perl
use strict;
use warnings;

use Array::Utils qw(:all);

my @list_01 = qw/Hans Otto Fritz/;
my @list_02 = qw/Wilhelm Otto/;

# get items from array @list_01 that are not in array @list_02
my @minus = array_minus(@list_01, @list_02);

print join(", ", @list_01), "\n";
print join(", ", @list_02), "\n";
print join(", ", @minus), "\n";
