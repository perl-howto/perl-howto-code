# Shamelessly stolen from https://metacpan.org/pod/Dancer2
use Dancer2;
get '/' => sub { "Hello World from buildpack_deps\n" };
dance;
