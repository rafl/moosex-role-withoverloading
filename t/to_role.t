use strict;
use warnings;
use Test::More;
use overload ();

use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { use_ok('OtherClass') }

ok(OtherClass->meta->does_role('Role'));
ok(OtherClass->meta->does_role('OtherRole'));

ok(overload::Overloaded('Role'));
ok(overload::Overloaded('OtherRole'));
ok(overload::Overloaded('OtherClass'));
ok(overload::Method('Role', q{""}));
ok(overload::Method('OtherRole', q{""}));
ok(overload::Method('OtherClass', q{""}));

my $foo = OtherClass->new({ message => 'foo' });
isa_ok($foo, 'OtherClass');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

done_testing;
