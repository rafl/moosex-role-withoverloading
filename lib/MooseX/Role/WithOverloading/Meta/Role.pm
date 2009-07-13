package MooseX::Role::WithOverloading::Meta::Role;

use Moose::Role;
use namespace::autoclean;

override apply => sub {
    my ($self, $other, @args) = @_;

    Moose->throw_error('You must pass in an blessed instance')
        unless blessed $other;

    if ($other->isa('Moose::Meta::Role')) {
        require MooseX::Role::WithOverloading::Meta::Role::Application::ToRole;
        return MooseX::Role::WithOverloading::Meta::Role::Application::ToRole->new(@args)->apply($self, $other);
    }
    elsif ($other->isa('Moose::Meta::Class')) {
        require MooseX::Role::WithOverloading::Meta::Role::Application::ToClass;
        return MooseX::Role::WithOverloading::Meta::Role::Application::ToClass->new(@args)->apply($self, $other);
    }
    else {
        require MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance;
        return MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance->new(@args)->apply($self, $other);
    }
};

1;
