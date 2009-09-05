package MooseX::Role::WithOverloading::Meta::Role::Application::ToRole;

use Moose::Role;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToClass';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance';
use namespace::autoclean;

with 'MooseX::Role::WithOverloading::Meta::Role::Application';

around apply => sub {
    my ($next, $self, $role1, $role2) = @_;
    return $self->$next(
        $role1,
        Moose::Util::MetaRole::apply_metaclass_roles(
            for_class                           => $role2,
            application_to_class_class_roles    => [ ToClass     ],
            application_to_role_class_roles     => [ __PACKAGE__ ],
            application_to_instance_class_roles => [ ToInstance  ],
        ),
    );
};

1;
