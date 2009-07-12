package MooseX::Role::WithOverloading;

use Moose::Role ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use MooseX::Role::WithOverloading::Meta::Role;

Moose::Exporter->setup_import_methods(also => 'Moose::Role');

sub init_meta {
    my ($class, %opts) = @_;
    my $meta = Moose::Role->init_meta(%opts);

    Moose::Util::MetaRole::apply_metaclass_roles(
        for_class       => $opts{for_class},
        metaclass_roles => ['MooseX::Role::WithOverloading::Meta::Role'],
    );

    return $meta;
}

1;
