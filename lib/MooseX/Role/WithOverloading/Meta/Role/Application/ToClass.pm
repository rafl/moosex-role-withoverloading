package MooseX::Role::WithOverloading::Meta::Role::Application::ToClass;

use Moose;
use overload ();
use Sub::Identify qw/get_code_info/;
use MooseX::Types::Moose qw/ArrayRef Str/;
use namespace::autoclean;

extends 'Moose::Meta::Role::Application::ToClass';

has overload_ops => (
    is      => 'ro',
    isa     => ArrayRef[Str],
    builder => '_build_overload_ops',
);

sub _build_overload_ops {
    return [map { split /\s+/ } values %overload::ops];
}

after apply_methods => sub {
    my ($self, $role, $class) = @_;
    return unless overload::Overloaded($role->name);

    $class->add_method('()' => $role->get_package_symbol('&()'));
    $class->add_package_symbol('$()' => $role->get_package_symbol('$()'))
        if $role->has_package_symbol('$()');
    $class->namespace->{OVERLOAD}->{dummy}++;

    for my $op (@{ $self->overload_ops }) {
        my $code_sym = '&(' . $op;

        next if $class->has_package_symbol($code_sym);
        next unless $role->has_package_symbol($code_sym);

        my $meth = $role->get_package_symbol($code_sym);
        next unless $meth;

        if (join(q{::} => get_code_info($meth)) eq 'overload::nil') {
            my $scalar_sym = qq{\$($op};
            $class->add_package_symbol($code_sym => $meth);
            $class->add_package_symbol(
                $scalar_sym => ${ $role->get_package_symbol($scalar_sym) },
            );
        }
        else {
            $class->add_method(qq{($op} => $meth);
        }
    }
};

1;
