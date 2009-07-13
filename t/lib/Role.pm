package Role;

use MooseX::Role::WithOverloading;
use namespace::clean -except => 'meta';

use overload
    q{""}    => 'as_string',
    fallback => 1;

has message => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub as_string { shift->message }

1;
