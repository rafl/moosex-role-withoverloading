package MooseX::Role::WithOverloading::Meta::Role::Application::FixOverloadedRefs;
# ABSTRACT: Fix up magic when applying roles to instances with magic on old perls

use Moose::Role;
use namespace::autoclean;

if ($] < 5.008009) {
    after apply => sub {
        reset_amagic($_[2]);
    };
}

=begin Pod::Coverage

reset_amagic

=end Pod::Coverage

=cut

1;
