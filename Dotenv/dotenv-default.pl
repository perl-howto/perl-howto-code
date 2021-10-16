#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use Dotenv;      # exports nothing
Dotenv->load;    # merge the content of .env in %ENV

my @config_vars = qw/
  APP_STAGE
  APP_SSH_OPTS
  APP_SSH_KEY_FILE
  APP_DB_HOST
  APP_LOG_LEVEL
  FOO
  /;

foreach my $config_var ( sort @config_vars ) {
    say "$config_var = $ENV{$config_var}";
}
