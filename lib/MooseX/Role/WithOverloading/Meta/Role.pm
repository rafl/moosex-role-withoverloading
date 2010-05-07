package MooseX::Role::WithOverloading::Meta::Role;
# ABSTRACT: Roles which support overloading

use Moose 0.94 ();
use Moose::Role;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Composite', 'CompositionRole';
use namespace::autoclean;

around composition_class_roles => sub {
    my ($orig, $self) = @_;
    return $self->$orig, CompositionRole;
};

1;
