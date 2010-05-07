use strict;
use warnings;
use Test::More 0.88;
use overload ();

use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { use_ok('ClassWithCombiningRole') }

ok(ClassWithCombiningRole->meta->does_role('Role'));
ok(ClassWithCombiningRole->meta->does_role('UnrelatedRole'));
ok(ClassWithCombiningRole->meta->does_role('CombiningRole'));

ok(!overload::Overloaded('UnrelatedRole'));
ok(overload::Overloaded('Role'));
ok(overload::Overloaded('CombiningRole'));
ok(overload::Overloaded('ClassWithCombiningRole'));
ok(!overload::Method('UnrelatedRole', q{""}));
ok(overload::Method('Role', q{""}));
ok(overload::Method('CombiningRole', q{""}));
ok(overload::Method('ClassWithCombiningRole', q{""}));

my $foo = ClassWithCombiningRole->new({ message => 'foo' });
isa_ok($foo, 'ClassWithCombiningRole');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

done_testing;
