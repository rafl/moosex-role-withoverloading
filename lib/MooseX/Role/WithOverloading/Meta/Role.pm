package MooseX::Role::WithOverloading::Meta::Role;
# ABSTRACT: Roles which support overloading

use Moose::Role;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Composite', 'CompositionRole';
use namespace::autoclean;

has '+composition_class_roles' => (
    default => [ CompositionRole ],
);

1;


