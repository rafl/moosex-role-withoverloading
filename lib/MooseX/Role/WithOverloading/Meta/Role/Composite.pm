package MooseX::Role::WithOverloading::Meta::Role::Composite;
# ABSTRACT: Role for composite roles which support overloading
use Moose::Role;
use Moose::Util::MetaRole;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::Composite::ToClass';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::Composite::ToRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::Composite::ToInstance';

use namespace::autoclean;

=method apply_params

Wrapped method to apply various metaclass roles to aid with role composition.

=cut

around apply_params => sub {
    my ($next, $self, @args) = @_;
    return Moose::Util::MetaRole::apply_metaclass_roles(
        for_class                           => $self->$next(@args),
        application_to_class_class_roles    => [ ToClass    ],
        application_to_role_class_roles     => [ ToRole     ],
        application_to_instance_class_roles => [ ToInstance ],
    );
};

1;
