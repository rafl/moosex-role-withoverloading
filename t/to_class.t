use strict;
use warnings;
use Test::More;
use overload ();

use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { use_ok('SomeClass') }

ok(SomeClass->meta->does_role('Role'));

ok(overload::Overloaded('Role'));
ok(overload::Overloaded('SomeClass'));
ok(overload::Method('Role', q{""}));
ok(overload::Method('SomeClass', q{""}));

my $foo = SomeClass->new({ message => 'foo' });
isa_ok($foo, 'SomeClass');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

done_testing;
