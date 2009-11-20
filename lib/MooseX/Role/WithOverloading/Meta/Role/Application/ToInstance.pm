package MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance;
# ABSTRACT: Roles which support overloading

use Moose::Role;
use namespace::autoclean;

with qw(
    MooseX::Role::WithOverloading::Meta::Role::Application
    MooseX::Role::WithOverloading::Meta::Role::Application::FixOverloadedRefs
);

1;
