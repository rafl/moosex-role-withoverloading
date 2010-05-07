use strict;
use warnings;
use Test::More 0.88;
use overload ();

use FindBin;
use lib "$FindBin::Bin/lib";

use Role;
use UnrelatedRole;

{
    package MyClass;
    use Moose;
    use namespace::autoclean;
}

my $foo = MyClass->new;

Moose::Meta::Role->combine(
    [ 'Role'          => undef ],
    [ 'UnrelatedRole' => undef ],
)->apply($foo);

isa_ok($foo, 'MyClass');

ok(overload::Overloaded('Role'));
ok(overload::Overloaded(ref $foo));
ok(overload::Method('Role', q{""}));
ok(overload::Method(ref $foo, q{""}));

$foo->message('foo');

my $str = "${foo}";
is($str, 'foo');

done_testing;
