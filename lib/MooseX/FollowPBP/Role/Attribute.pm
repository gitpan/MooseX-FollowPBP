package MooseX::FollowPBP::Role::Attribute;
BEGIN {
  $MooseX::FollowPBP::Role::Attribute::VERSION = '0.03';
}

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



__END__
=pod

=head1 NAME

MooseX::FollowPBP::Role::Attribute

=head1 VERSION

version 0.03

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

  Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Dave Rolsky.

This is free software, licensed under:

  The Artistic License 2.0

=cut

