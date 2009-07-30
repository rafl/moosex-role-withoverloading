package MooseX::Role::WithOverloading::Meta::Role::Composite;

use Moose::Role;
use Moose::Util::MetaRole;
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::RoleSummation';

use namespace::clean -except => 'meta';

around _new => sub {
    my ($next, $self, @args) = @_;
    return Moose::Util::MetaRole::apply_metaclass_roles(
        for                                    => $self->$next(@args),
        application_role_summation_class_roles => [ RoleSummation ],
    );
};

1;
