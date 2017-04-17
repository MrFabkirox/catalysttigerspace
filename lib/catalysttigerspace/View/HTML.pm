package catalysttigerspace::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    # Change default TT extension
    TEMPLATE_EXTENSION => '.tt2',
    # Set the location for TT files
    INCLUDE_PATH => [
            catalysttigerspace->path_to( 'root', 'src' ),
        ],
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'wrapper.tt2',
);
=head1 NAME

catalysttigerspace::View::HTML - TT View for catalysttigerspace

=head1 DESCRIPTION

TT View for catalysttigerspace.

=head1 SEE ALSO

L<catalysttigerspace>

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
