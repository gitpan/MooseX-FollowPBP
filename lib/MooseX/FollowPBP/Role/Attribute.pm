package MooseX::FollowPBP::Role::Attribute;

use strict;
use warnings;

use Moose::Role;


before '_process_options' => sub
{
    my $class   = shift;
    my $name    = shift;
    my $options = shift;

    if ( exists $options->{is} &&
         ! ( exists $options->{reader} || exists $options->{writer} ) )
    {
        my $get;
        my $set;

        if ( $name =~ s/^_// )
        {
            $get = '_get_';
            $set = '_set_';
        }
        else
        {
            $get = 'get_';
            $set = 'set_';
        }

        $options->{reader} = $get . $name;

        if ( $options->{is} eq 'rw' )
        {
            $options->{writer} = $set . $name;
        }

        delete $options->{is};
    }
};

no Moose::Role;

1;

=head1 NAME

MooseX::FollowPBP::Role::Attribute - Names accessors in the I<Perl Best Practices> style

=head1 SYNOPSIS

  Moose::Util::MetaRole::apply_metaclass_roles
      ( for_class => $p{for_class},
        attribute_metaclass_roles =>
        ['MooseX::FollowPBP::Role::Attribute'],
      );

=head1 DESCRIPTION

This role applies a method modifier to the C<_process_options()>
method, and tweaks the reader and writer parameters so that they
follow the style recommended in I<Perl Best Practices>.

=head1 AUTHOR

Dave Rolsky, C<< <autarch@urth.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

