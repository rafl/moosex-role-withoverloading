package MooseX::Role::WithOverloading::Meta::Role::Application::FixOverloadedRefs;

use Moose::Role;
use namespace::autoclean;

if ($] < 5.008009) {
    after apply => sub {
        reset_amagic($_[2]);
    };
}

1;
