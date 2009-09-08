package MooseX::Role::WithOverloading::Meta::Role::Application;
# ABSTRACT: Role application role for Roles which support overloading

use Moose::Role;
use overload ();
use MooseX::Types::Moose qw/ArrayRef Str/;
use namespace::autoclean;

requires 'apply_methods';

=method overload_ops

Returns an arrayref of the names of overloaded operations

=cut

has overload_ops => (
    is      => 'ro',
    isa     => ArrayRef[Str],
    builder => '_build_overload_ops',
);

sub _build_overload_ops {
    return [map { split /\s+/ } values %overload::ops];
}

=method apply_methods ($role, $other)

Wrapped with an after modifier which calls the C<< ->apply_overloading >>
method.

=cut

after apply_methods => sub {
    my ($self, $role, $other) = @_;
    $self->apply_overloading($role, $other);
};

=method apply_overloading ($role, $other)

Does the heavy lifting of applying overload operations to
a class or role which the role is applied to.

=cut

sub apply_overloading {
    my ($self, $role, $other) = @_;
    return unless overload::Overloaded($role->name);

    # overloading predicate method
    $other->add_package_symbol('&()' => $role->get_package_symbol('&()'));
    # fallback value
    $other->add_package_symbol('$()' => $role->get_package_symbol('$()'))
        if $role->has_package_symbol('$()');
    # register with magic by touching
    $other->get_package_symbol('%OVERLOAD')->{dummy}++;

    for my $op (@{ $self->overload_ops }) {
        my $code_sym = '&(' . $op;

        next if overload::Method($other->name, $op);
        next unless $role->has_package_symbol($code_sym);

        my $meth = $role->get_package_symbol($code_sym);
        next unless $meth;

        # when using "use overload $op => sub { };" this is the actual method
        # to be called on overloading. otherwise it's \&overload::nil. see
        # below.
        $other->add_package_symbol($code_sym => $meth);

        # when using "use overload $op => 'method_name';" overload::nil is
        # installed into the code slot of the glob and the actual method called
        # is determined by the scalar slot of the same glob.
        if ($meth == \&overload::nil) {
            my $scalar_sym = qq{\$($op};
            $other->add_package_symbol(
                $scalar_sym => ${ $role->get_package_symbol($scalar_sym) },
            );
        }
    }
}

1;
