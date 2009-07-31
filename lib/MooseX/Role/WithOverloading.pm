package MooseX::Role::WithOverloading;

use Moose::Role ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use aliased 'MooseX::Role::WithOverloading::Meta::Role', 'MetaRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToClass';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance';

use namespace::clean;

Moose::Exporter->setup_import_methods(also => 'Moose::Role');

sub init_meta {
    my ($class, %opts) = @_;
    my $meta = Moose::Role->init_meta(%opts);

    return Moose::Util::MetaRole::apply_metaclass_roles(
        for                                 => $meta,
        metaclass_roles                     => [ MetaRole   ],
        application_to_class_class_roles    => [ ToClass    ],
        application_to_role_class_roles     => [ ToRole     ],
        application_to_instance_class_roles => [ ToInstance ],
    );
}

1;
