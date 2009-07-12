use strict;
use warnings;
use Test::More;

use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { use_ok('Class') }

ok(Class->meta->does_role('Role'));

my $foo = Class->new({ message => 'foo' });
isa_ok($foo, 'Class');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

done_testing;
