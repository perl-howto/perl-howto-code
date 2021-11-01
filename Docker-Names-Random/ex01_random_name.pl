#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

# As an object (if you create many, this is more efficient).
use Docker::Names::Random;

my $dnr         = Docker::Names::Random->new();
my $random_name = $dnr->docker_name();

say $random_name;
