package MooseX::Role::WithOverloading::Meta::Role::Application::FixOverloadedRefs;

use Moose::Role;
use namespace::autoclean;

after apply => sub {
    reset_amagic($_[2]);
    ();
};

1;
