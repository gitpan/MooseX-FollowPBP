package MooseX::FollowPBP;

use strict;
use warnings;

our $VERSION = '0.02';

use Moose 0.56 ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use MooseX::FollowPBP::Role::Attribute;

Moose::Exporter->setup_import_methods();

sub init_meta
{
    shift;
    my %p = @_;

    Moose->init_meta(%p);

    return
        Moose::Util::MetaRole::apply_metaclass_roles
            ( for_class => $p{for_class},
              attribute_metaclass_roles =>
              ['MooseX::FollowPBP::Role::Attribute'],
            );
}

1;

__END__

=pod

=head1 NAME

MooseX::FollowPBP - Name your accessors get_foo() and set_foo()

=head1 SYNOPSIS

    use MooseX::FollowPBP;
    use Moose;

    # make some attributes

=head1 DESCRIPTION

This module does not provide any methods. Simply loading it changes
the default naming policy for the loading class so that accessors are
separated into get and set methods. The get methods are prefixed with
"get_" as the accessor, while set methods are prefixed with
"set_". This is the naming style recommended by Damian Conway in
I<Perl Best Practices>.

If you define an attribute with a leading underscore, then both the
get and set method will also have an underscore prefix.

If you explicitly set a "reader" or "writer" name when creating an
attribute, then that attribute's naming scheme is left unchanged.

=head1 AUTHOR

Dave Rolsky, C<< <autarch@urth.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-moosex-followpbp@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
