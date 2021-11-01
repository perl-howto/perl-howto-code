#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

# As an imported function.
use Docker::Names::Random qw( docker_name );

my $random_name = docker_name();

say $random_name;
