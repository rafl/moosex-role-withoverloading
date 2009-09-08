package MooseX::Role::WithOverloading::Meta::Role::Application::Composite;
# ABSTRACT: Roles which support overloading

use Moose::Role;
use namespace::autoclean;

with 'MooseX::Role::WithOverloading::Meta::Role::Application';

around apply_overloading => sub {
    my ($next, $self, $composite, $other) = @_;
    for my $role (@{ $composite->get_roles }) {
        $self->$next($role, $other);
    }
};

1;
