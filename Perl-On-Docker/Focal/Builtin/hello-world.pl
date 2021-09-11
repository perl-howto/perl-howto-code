use Dancer2;

# https://metacpan.org/dist/Dancer2/view/lib/Dancer2/Tutorial.pod
set 'logger'       => 'console';
set 'log'          => 'debug';
set 'show_errors'  => 1;
set 'startup_info' => 1;

get '/' => sub {
    debug "Running route /";
    return "Hello World from builtin\n";
};

dance;
