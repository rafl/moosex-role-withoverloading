package MooseX::Role::WithOverloading;
# ABSTRACT: Roles which support overloading
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
        for_class                           => $meta,
        metaclass_roles                     => [ MetaRole   ],
        application_to_class_class_roles    => [ ToClass    ],
        application_to_role_class_roles     => [ ToRole     ],
        application_to_instance_class_roles => [ ToInstance ],
    );
}

1;

=head1 SYNOPSIS

    package MyRole;
    use MooseX::Role::WithOverloading;
    use namespace::autoclean;

    use overload
        q{""}    => 'as_string',
        fallback => 1;

    has message => (
        is       => 'rw',
        isa      => 'Str',
    );

    sub as_string { shift->message }

    package MyClass;
    use Moose;
    use namespace::autoclean;

    with 'MyRole';

    package main;

    my $i = MyClass->new( message => 'foobar' );
    print $i; # Prints 'foobar'

=head1 DESCRIPTION

MooseX::Role::WithOverloading allows you to write a L<Moose::Role>
which uses operator overloading to overload any operation supported by the
L<overload> pragma.

=begin Pod::Coverage

init_meta

=end Pod::Coverage

=cut

