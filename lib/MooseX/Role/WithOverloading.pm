package MooseX::Role::WithOverloading;

use Moose::Role ();
use Moose::Exporter;
use Moose::Util::MetaRole;

Moose::Exporter->setup_import_methods(also => 'Moose::Role');

sub init_meta {
    my ($class, %opts) = @_;
    my $meta = Moose::Role->init_meta(%opts);
    return $meta;
}

1;
