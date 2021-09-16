#!/usr/bin/env perl
use strict;
use warnings;

use Dancer2;
use Redis;

set 'logger'       => 'console';
set 'log'          => 'debug';
set 'show_errors'  => 1;
set 'startup_info' => 1;

my $redis_host = 'myredis';
my $redis_port =  6379;

my $redis = Redis->new( server => "$redis_host:$redis_port" );

get '/' => sub {
    my $counter = $redis->incr('counter');
    debug "Counter: $counter";
    return "$counter\n";
};

dance;
