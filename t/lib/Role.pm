package Role;

use MooseX::Role::WithOverloading;
use namespace::clean -except => 'meta';

use overload
    q{""}    => 'message',
    fallback => 1;

has message => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

1;
