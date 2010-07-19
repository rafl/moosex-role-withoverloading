package MooseX::Role::WithOverloading::Meta::Role::Application::ToRole;
# ABSTRACT: Roles which support overloading

use Moose::Role;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToClass';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance';
use namespace::autoclean;

with 'MooseX::Role::WithOverloading::Meta::Role::Application';

around apply => sub {
    my ($next, $self, $role1, $role2) = @_;
    return $self->$next(
        $role1,
        Moose::Util::MetaRole::apply_metaroles(
            for            => $role2,
            role_metaroles => {
                application_to_class    => [ToClass],
                application_to_role     => [__PACKAGE__],
                application_to_instance => [ToInstance],
            },
        ),
    );
};

1;
