package MooseX::Role::WithOverloading::Meta::Role;
# ABSTRACT: Roles which support overloading

use Moose ();
use Moose::Role;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Composite', 'CompositionRole';
use namespace::autoclean;

$Moose::VERSION >= 0.9301
    ? around composition_class_roles => sub {
        my ($orig, $self) = @_;
        return $self->$orig,
            CompositionRole;
    }
    : has '+composition_class_roles' => (
        default => sub { [ CompositionRole ] },
    );

1;
