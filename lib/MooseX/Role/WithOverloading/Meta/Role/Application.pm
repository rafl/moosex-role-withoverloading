package MooseX::Role::WithOverloading::Meta::Role::Application;

use Moose::Role;
use overload ();
use MooseX::Types::Moose qw/ArrayRef Str/;
use namespace::autoclean;

has overload_ops => (
    is      => 'ro',
    isa     => ArrayRef[Str],
    builder => '_build_overload_ops',
);

sub _build_overload_ops {
    return [map { split /\s+/ } values %overload::ops];
}

after apply_methods => sub {
    my ($self, $role, $other) = @_;
    return unless overload::Overloaded($role->name);

    $other->add_package_symbol('&()' => $role->get_package_symbol('&()'));
    $other->add_package_symbol('$()' => $role->get_package_symbol('$()'))
        if $role->has_package_symbol('$()');
    # TODO: figure out why the mop variant doesn't work
    # $other->namespace->{OVERLOAD}->{dummy}++;
    { no strict 'refs'; ${ $other->name . '::OVERLOAD' }{dummy}++; } 

    for my $op (@{ $self->overload_ops }) {
        my $code_sym = '&(' . $op;

        next if overload::Method($other->name, $op);
        next unless $role->has_package_symbol($code_sym);

        my $meth = $role->get_package_symbol($code_sym);
        next unless $meth;

        if ($meth == \&overload::nil) {
            my $scalar_sym = qq{\$($op};
            $other->add_package_symbol($code_sym => $meth);
            $other->add_package_symbol(
                $scalar_sym => ${ $role->get_package_symbol($scalar_sym) },
            );
        }
        else {
            $other->add_package_symbol(qq{&($op} => $meth);
        }
    }
};

1;
